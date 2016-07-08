 <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
	<script src="../js/jquery-1.11.2.min.js"></script>
	<script src="../js/bootstrap.min.js"></script>
<%--
<script src="../js/jquery-1.11.2.min.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="../js/bootstrap.min.js"></script>
<link href="../css/bootstrap.min.css" rel="stylesheet">

<title>Hadoop-状态监控</title>
</head>
<body>
	<jsp:include page="header.jsp" flush="true" />
	<!-- /.container-fluid -->
	<div>
		<h1>Overview</h1>
		<div>
			<table class="table table-striped table-bordered" id="overview-table">

			</table>
		</div>
		<hr>
		<h1>Summary</h1>
		<div>
			<table class="table talbe-striped table-bordered" id="summary-table">
			</table>
		</div>
	</div>
	<script>
		$(document)
				.ready(
						function() {
							var url = "http://10.10.108.101:50070/jmx?qry=Hadoop:service=NameNode,name=NameNodeInfo&callback=?"
							$.getJSON(url, function(data) {
								var nndata = data.beans[0];
								$("#overview-table").append(
										"<tr><th>启动时间:</th><td>"
												+ nndata.NNStarted
												+ "</td></tr>");
								$("#overview-table").append(
										"<tr><th>版本:</th><td>" + nndata.Version
												+ "</td></tr>");
								$("#overview-table").append(
										"<tr><th>上次编译:</th><td>"
												+ nndata.CompileInfo
												+ "</td></tr>");
								$("#overview-table").append(
										"<tr><th>Cluster ID:</th><td>"
												+ nndata.ClusterId
												+ "</td></tr>");
								$("#overview-table").append(
										"<tr><th>Block Pool ID:</th><td>"
												+ nndata.BlockPoolId
												+ "</td></tr>");

							});
						});
	</script>
</body>
</html> --%>

<link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="../css/hadoop.css" />
<title>主节点信息</title>
</head>
<body>
<jsp:include page="header.jsp" flush="true" />
<header class="navbar bs-docs-nav" role="banner">
<div class="container">
  <ul class="nav nav-tabs" id="ui-tabs">
    <li role="presentation" class="active"><a href="#tab-overview">Overview / 概况</a></li>
    <li role="presentation"><a href="#tab-datanode">Datanodes / 数据结点</a></li>
    <li role="presentation"><a href="#tab-snapshot">Snapshot / 快照</a></li>
  </ul>
</div>
</header>

<div class="container">

<div id="alert-panel">
  <div class="alert alert-danger">
    <button type="button" class="close" onclick="$('#alert-panel').hide();">&times;</button>
    <div class="alert-body" id="alert-panel-body"></div>
  </div>
</div>

<div class="tab-content">
  <div class="tab-pane" id="tab-overview"></div>
  <div class="tab-pane" id="tab-datanode"></div>
  <div class="tab-pane" id="tab-snapshot"></div>
  <div class="tab-pane" id="tab-startup-progress"></div>
</div>

<div class="row">
  <hr />
  <div class="col-xs-2"><p></p></div>
</div>
</div>

<script type="text/x-dust-template" id="tmpl-dfshealth">

{#nn}
{@if cond="{DistinctVersionCount} > 1 || '{RollingUpgradeStatus}'.length || !'{UpgradeFinalized}'"}
<div class="alert alert-dismissable alert-info">
  <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>

  {#RollingUpgradeStatus}
    <p>Rolling upgrade started at {#helper_date_tostring value="{startTime}"/}. </br>
    {#createdRollbackImages}
      Rollback image has been created. Proceed to upgrade daemons.
      {:else}
      Rollback image has not been created.
    {/createdRollbackImages}
    </p>
  {/RollingUpgradeStatus}

  {@if cond="{DistinctVersionCount} > 1"}
    There are {DistinctVersionCount} versions of datanodes currently live:
    {#DistinctVersions}
    {key} ({value}) {@sep},{/sep}
    {/DistinctVersions}
  {/if}

  {^UpgradeFinalized}
     <p>Upgrade in progress. Not yet finalized.</p>
  {/UpgradeFinalized}
</div>
{/if}

{@if cond="{NumberOfMissingBlocks} > 0"}
<div class="alert alert-dismissable alert-warning">
  <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>

  <p>There are {NumberOfMissingBlocks} missing blocks. The following files may be corrupted:</p>
  <br/>
  <div class="well">
    {#CorruptFiles}
    {.}<br/>
    {/CorruptFiles}
  </div>
  <p>Please check the logs or run fsck in order to identify the missing blocks. See the Hadoop FAQ for common causes and potential solutions.</p>
</div>
{/if}
{/nn}

<div class="page-header"><h1>Overview / 概况 {#nnstat}<small>'{HostAndPort}' ({State})</small>{/nnstat}</h1></div>
{#nn}
<table class="table table-bordered table-striped">
  <tr><th>开机时间:</th><td>{NNStarted}</td></tr>
  <tr><th>版本:</th><td>{Version}</td></tr>
  <tr><th>上次编译:</th><td>{CompileInfo}</td></tr>
  <tr><th>集群 ID:</th><td>{ClusterId}</td></tr>
  <tr><th>数据块池 ID:</th><td>{BlockPoolId}</td></tr>
</table>
{/nn}

<div class="page-header"><h1>Summary / 总体情况</h1></div>
<p>
  Security 已被 {#nnstat}{#SecurityEnabled}开启{:else}关闭{/SecurityEnabled}{/nnstat}.</p>
<p>{#nn}{#Safemode}{.}{:else}安全模式已被关闭.{/Safemode}{/nn}</p>

<p>
  {#fs}
  共计{FilesTotal}个文件和目录, {@math key="{FilesTotal}" method="add" operand="{BlocksTotal}"/} 个文件包含有 {BlocksTotal} 个数据块.
  {#helper_fs_max_objects/}
  {/fs}
</p>
{#mem.HeapMemoryUsage}
<p>堆内存共有 {committed|fmt_bytes}，已用{used|fmt_bytes}， 最大堆内存为 {max|fmt_bytes}. </p>
{/mem.HeapMemoryUsage}

{#mem.NonHeapMemoryUsage}
<p>非堆内存共有 {committed|fmt_bytes}， 已用 {used|fmt_bytes}，最大非堆内存为 {max|fmt_bytes}. </p>
{/mem.NonHeapMemoryUsage}

{#nn}
<table class="table table-bordered table-striped">
  <tr><th> 总容量:</th><td>{Total|fmt_bytes}</td></tr>
  <tr><th> DFS使用容量:</th><td>{Used|fmt_bytes}</td></tr>
  <tr><th> 非DFS使用容量:</th><td>{NonDfsUsedSpace|fmt_bytes}</td></tr>
  <tr><th> DFS未使用容量:</th><td>{Free|fmt_bytes}</td></tr>
  <tr><th> DFS使用比例:</th><td>{PercentUsed|fmt_percentage}</td></tr>
  <tr><th> DFS剩余比例:</th><td>{PercentRemaining|fmt_percentage}</td></tr>
  <tr><th> 数据块池使用:</th><td>{BlockPoolUsedSpace|fmt_bytes}</td></tr>
  <tr><th> 数据块池使用比例:</th><td>{PercentBlockPoolUsed|fmt_percentage}</td></tr>
  <tr><th> 数据节点使用比例 (Min/Median/Max/stdDev): </th>
	<td>{#NodeUsage.nodeUsage}{min} / {median} / {max} / {stdDev}{/NodeUsage.nodeUsage}</td></tr>
{/nn}

{#fs}
  <tr><th><a href="#tab-datanode">运行中节点</a></th><td>{NumLiveDataNodes} (Decommissioned: {NumDecomLiveDataNodes})</td></tr>
  <tr><th><a href="#tab-datanode">失败节点</a></th><td>{NumDeadDataNodes} (Decommissioned: {NumDecomDeadDataNodes})</td></tr>
  <tr><th><a href="#tab-datanode">停止的节点</a></th><td>{NumDecommissioningDataNodes}</td></tr>
  <tr><th title="Excludes missing blocks.">数据块副本数</th><td>{UnderReplicatedBlocks}</td></tr>
  <tr><th>删除的数据块数</th><td>{PendingDeletionBlocks}</td></tr>
{/fs}
</table>

<div class="page-header"><h1>NameNode Journal Status</h1></div>
<p><b>Current transaction ID:</b> {nn.JournalTransactionInfo.LastAppliedOrWrittenTxId}</p>
<table class="table" title="NameNode Journals">
  <thead>
	<tr><th>节点管理</th><th>State</th></tr>
  </thead>
  <tbody>
	{#nn.NameJournalStatus}
	<tr><td>{manager}</td><td>{stream}</td></tr>
	{/nn.NameJournalStatus}
  </tbody>
</table>

<div class="page-header"><h1>主节点存储</h1></div>
<table class="table" title="NameNode Storage">
  <thead><tr><td><b>存储目录</b></td><td><b>Type</b></td><td><b>状态</b></td></tr></thead>
  {#nn.NameDirStatuses}
  {#active}{#helper_dir_status type="Active"/}{/active}
  {#failed}{#helper_dir_status type="Failed"/}{/failed}
  {/nn.NameDirStatuses}
</table>
</script>

<script type="text/x-dust-template" id="tmpl-snapshot">
<div class="page-header"><h1>快照信息</h1></div>
<div class="page-header"><h1><small>快照表目录: {@size key=SnapshottableDirectories}{/size}</small></div>
<small>
<table class="table">
  <thead>
    <tr>
      <th>路径</th>
      <th>快照号</th>
      <th>快照定额</th>
      <th>时间改变</th>
      <th>权限</th>
      <th>拥有者</th>
      <th>组</th>
    </tr>
  </thead>
  {#SnapshottableDirectories}
  <tr>
    <td>{path}</td>
    <td>{snapshotNumber}</td>
    <td>{snapshotQuota}</td>
    <td>{modificationTime|date_tostring}</td>
    <td>{permission|helper_to_permission}</td>
    <td>{owner}</td>
    <td>{group}</td>
  </tr>
  {/SnapshottableDirectories}
</table>
</small>

<div class="page-header"><h1><small>Snapshotted directories: {@size key=Snapshots}{/size}</small></div>

<small>
<table class="table">
  <thead>
    <tr>
      <th>快照ID</th>
      <th>快照目录</th>
      <th>改变时间</th>
    </tr>
  </thead>
  {#Snapshots}
  <tr>
    <td>{snapshotID}</td>
    <td>{snapshotDirectory}</td>
    <td>{modificationTime|date_tostring}</td>
  </tr>
  {/Snapshots}
</table>
</small>
</script>

<script type="text/x-dust-template" id="tmpl-datanode">
<div class="page-header"><h1>数据节点信息</h1></div>
<div class="page-header"><h1><small>在运行中</small></h1></div>
<small>
<table class="table">
  <thead>
    <tr>
      <th>节点名称</th>
      <th>最后一次访问</th>
      <th>Admin状态</th>
      <th>总容量</th>
      <th>已用</th>
      <th>非DFS所用</th>
      <th>剩余</th>
      <th>块总量</th>
      <th>已用块池</th>
      <th>失败 Volumes</th>
      <th>版本</th>
    </tr>
  </thead>
  {#LiveNodes}
  <tr>
    <td>{name} ({xferaddr})</td>
    <td>{lastContact}</td>
    <td>{adminState}</td>
    <td>{capacity|fmt_bytes}</td>
    <td>{used|fmt_bytes}</td>
    <td>{nonDfsUsedSpace|fmt_bytes}</td>
    <td>{remaining|fmt_bytes}</td>
    <td>{numBlocks}</td>
    <td>{blockPoolUsed|fmt_bytes} ({blockPoolUsedPercent|fmt_percentage})</td>
    <td>{volfails}</td>
    <td>{version}</td>
  </tr>
  {/LiveNodes}
  {#DeadNodes}
  <tr class="danger">
    <td>{name} ({xferaddr})</td>
    <td>{lastContact}</td>
    <td>Dead{?decommissioned}, Decommissioned{/decommissioned}</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
  </tr>
  {/DeadNodes}
</table>
</small>

<div class="page-header"><h1><small>退役节点</small></h1></div>
<small>
<table class="table">
  <thead>
    <tr>
      <th>节点名称</th>
      <th>最近一次访问</th>
      <th>从属副本块</th>
      <th>没有可用副本快</th>
      <th>从属副本快 <br/>文件中的从属结构</th>
    </tr>
  </thead>
  {#DecomNodes}
  <tr>
    <td>{name} ({xferaddr})</td>
    <td>{lastContact}</td>
    <td>{underReplicatedBlocks}</td>
    <td>{decommissionOnlyReplicas}</td>
    <td>{underReplicateInOpenFiles}</td>
  </tr>
  {/DecomNodes}
</table>
</small>
</script>

<script type="text/x-dust-template" id="tmpl-startup-progress">
<div class="page-header"><h1>启动进程</h1></div>
<p>Elapsed Time: {elapsedTime|fmt_time}, Percent Complete: {percentComplete|fmt_percentage}</p>
<table class="table">
  <thead>
	<tr class="active">
	  <th>Phase</th>
	  <th style="text-align:center">Completion</th>
	  <th style="text-align:center">Elapsed Time</th>
	</tr>
  </thead>
  <tbody>
	{#phases}
	<tr class="phase">
	  <td class="startupdesc">{desc} {file} {size|fmt_bytes}</td>
	  <td style="text-align:center">{percentComplete|fmt_percentage}</td>
	  <td style="text-align:center">{elapsedTime|fmt_time}</td>
	</tr>
	{#steps root_file=file}
	<tr class="step">
	  <td class="startupdesc">{stepDesc} {stepFile} {stepSize|fmt_bytes} ({count}/{total})</td>
	  <td style="text-align:center">{percentComplete|fmt_percentage}</td>
	  <td></td>
	</tr>
	{/steps}
	{/phases}
  </tbody>
</table>
</script>

<script type="text/javascript" src="../js/dust-full-2.0.0.min.js">
</script><script type="text/javascript" src="../js/dust-helpers-1.1.1.min.js">
</script><script type="text/javascript" src="../js/dfs-dust.js">
</script><script type="text/javascript" src="../js/dfshealth.js">
</script>
<jsp:include page="footer.jsp" flush="true"></jsp:include>
