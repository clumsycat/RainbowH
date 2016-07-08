/**
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements. See the NOTICE file distributed with this
 * work for additional information regarding copyright ownership. The ASF
 * licenses this file to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 * http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 * License for the specific language governing permissions and limitations under
 * the License.
 */

	"use strict";

	dust.loadSource(dust.compile($('#tmpl-dfshealth').html(), 'dfshealth'));
	dust.loadSource(dust.compile($('#tmpl-startup-progress').html(),
			'startup-progress'));
	dust.loadSource(dust.compile($('#tmpl-datanode').html(), 'datanode-info'));
	dust.loadSource(dust.compile($('#tmpl-snapshot').html(), 'snapshot-info'));

	function load_overview() {
		var BEANS = [
				{
					"name" : "nn",
					"url" : "http://10.10.108.72:50070/jmx?qry=Hadoop:service=NameNode,name=NameNodeInfo&callback=?"
				},
				{
					"name" : "nnstat",
					"url" : "http://10.10.108.72:50070/jmx?qry=Hadoop:service=NameNode,name=NameNodeStatus&callback=?"
				},
				{
					"name" : "fs",
					"url" : "http://10.10.108.72:50070/jmx?qry=Hadoop:service=NameNode,name=FSNamesystemState&callback=?"
				},
				{
					"name" : "mem",
					"url" : "http://10.10.108.72:50070/jmx?qry=java.lang:type=Memory&callback=?"
				} ];

		var HELPERS = {
			'helper_fs_max_objects' : function(chunk, ctx, bodies, params) {
				var o = ctx.current();
				if (o.MaxObjects > 0) {
					chunk.write('('
							+ Math.round((o.FilesTotal + o.BlockTotal)
									/ o.MaxObjects * 100) * 100 + ')%');
				}
			},

			'helper_dir_status' : function(chunk, ctx, bodies, params) {
				var j = ctx.current();
				for ( var i in j) {
					chunk.write('<tr><td>' + i + '</td><td>' + j[i]
							+ '</td><td>' + params.type + '</td></tr>');
				}
			},

			'helper_date_tostring' : function(chunk, ctx, bodies, params) {
				var value = dust.helpers.tap(params.value, chunk, ctx);
				return chunk.write(''
						+ new Date(Number(value)).toLocaleString());
			}
		};

		var data = {};

		// Workarounds for the fact that JMXJsonServlet returns non-standard
		// JSON strings
		function workaround(nn) {
			nn.JournalTransactionInfo = JSON.parse(nn.JournalTransactionInfo);
			nn.NameJournalStatus = JSON.parse(nn.NameJournalStatus);
			nn.NameDirStatuses = JSON.parse(nn.NameDirStatuses);
			nn.NodeUsage = JSON.parse(nn.NodeUsage);
			nn.CorruptFiles = JSON.parse(nn.CorruptFiles);
			return nn;
		}
		
		function load_jsonp(beans, success_cb, error_cb) {
		    var data = {}, error = false, to_be_completed = beans.length;

		    $.each(beans, function(idx, b) {
		      if (error) {
		        return false;
		      }
		      $.getJSON(b.url, function (resp) {
		        data[b.name] = resp;
		        to_be_completed -= 1;
		        if (to_be_completed === 0) {
		          success_cb(data);
		        }
		      }).error(function (jqxhr, text, err) {
		        error = true;
		        error_cb(b.url, jqxhr, text, err);
		      });
		    });
		  }

		load_jsonp(BEANS, function(d) {
			for ( var k in d) {
				data[k] = k === 'nn' ? workaround(d[k].beans[0])
						: d[k].beans[0];
			}
			render();
		}, function(url, jqxhr, text, err) {
			show_err_msg('<p>Failed to retrieve data from ' + url + ', cause: '
					+ err + '</p>');
		});

		function render() {
			var base = dust.makeBase(HELPERS);
			dust.render('dfshealth', base.push(data), function(err, out) {
				$('#tab-overview').html(out);
				$('#ui-tabs a[href="#tab-overview"]').tab('show');
			});
		}
	}

	function show_err_msg(msg) {
		$('#alert-panel-body').html(msg);
		$('#alert-panel').show();
	}

	function ajax_error_handler(url, jqxhr, text, err) {
		show_err_msg('<p>Failed to retrieve data from ' + url + ', cause: '
				+ err + '</p>');
	}

	function load_datanode_info() {
		function workaround(r) {
			function node_map_to_array(nodes) {
				var res = [];
				for ( var n in nodes) {
					var p = nodes[n];
					p.name = n;
					res.push(p);
				}
				return res;
			}

			r.LiveNodes = node_map_to_array(JSON.parse(r.LiveNodes));
			r.DeadNodes = node_map_to_array(JSON.parse(r.DeadNodes));
			r.DecomNodes = node_map_to_array(JSON.parse(r.DecomNodes));
			return r;
		}

		$
				.getJSON(
						'http://10.10.108.72:50070/jmx?qry=Hadoop:service=NameNode,name=NameNodeInfo&callback=?',
						function(resp) {
							var data = workaround(resp.beans[0]);
							dust.render('datanode-info', data, function(err,
									out) {
								$('#tab-datanode').html(out);
								$('#ui-tabs a[href="#tab-datanode"]').tab(
										'show');
							});
						}).error(ajax_error_handler);
	}

	function load_snapshot_info() {
		$
				.getJSON(
						'http://10.10.108.72:50070/jmx?qry=Hadoop:service=NameNode,name=SnapshotInfo&callback=?',
						function(resp) {
							dust.render('snapshot-info', resp.beans[0],
									function(err, out) {
										$('#tab-snapshot').html(out);
										$('#ui-tabs a[href="#tab-snapshot"]')
												.tab('show');
									});
						}).error(ajax_error_handler);
	}

	function load_page() {
		var hash = window.location.hash;
		switch (hash) {
		case "#tab-datanode":
			load_datanode_info();
			break;
		case "#tab-snapshot":
			load_snapshot_info();
			break;
		case "#tab-overview":
			load_overview();
			break;
		default:
			window.location.hash = "tab-overview";
			break;
		}
	}
	load_page();

	$(window).bind('hashchange', function() {
		load_page();
	});

