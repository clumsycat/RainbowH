<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="../js/jquery-1.11.2.min.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="../js/bootstrap.min.js"></script>
<link href="../css/bootstrap.min.css" rel="stylesheet">

<title>RainBowH 用户界面</title>
</head>
<body>
	<jsp:include page="header.jsp" flush="true"/>
	 <!-- <iframe name="impala-frame"   frameborder="0" id="impala-frame" scrolling="no" width="100%"  height="600px"src="http://10.10.108.101:50070/explorer.html" >
	</iframe> -->
<div class="modal" id="file-info" tabindex="-1" role="dialog" aria-hidden="true">
      <div class="modal-dialog">
	<div class="modal-content">
	  <div class="modal-header"><button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	    <h4 class="modal-title" id="file-info-title">File information</h4>
	  </div>
	  <div class="modal-body" id="file-info-body">
	    <a id="file-info-download">Download</a>
        <!--<a id="file-info-preview" style="cursor:pointer">Tail the file (last 32K)</a>-->
	    <hr />
	    <div class="panel panel-success" id="file-info-blockinfo-panel">
	      <div class="panel-heading">
		Block information -- 
		<select class="btn btn-default" id="file-info-blockinfo-list">
		</select>
	      </div>
	      <div class="panel-body" id="file-info-blockinfo-body"></div>
	    </div>
	    <div class="panel panel-info" id="file-info-tail" style="display:none">
	      <div class="panel-heading">File contents</div>
	      <div class="panel-body">
		<div class="input-group-sm">
		<textarea class="form-control" style="height: 150px" id="file-info-preview-body"></textarea>
		</div>
	      </div>
	    </div>
	  </div>
	  <div class="modal-footer"><button type="button" class="btn btn-success"
					    data-dismiss="modal">Close</button></div>
	</div>
      </div>
    </div>
    <div class="container">
      <div class="page-header">
	<h1>Browse Directory</h1>
      </div>
      <div class="alert alert-danger" id="alert-panel" style="display:none">
	<button type="button" class="close" onclick="$('#alert-panel').hide();">&times;</button>
	<div class="alert-body" id="alert-panel-body"></div>
      </div>
      <div class="row">
	<form onsubmit="return false;">
	  <div class="input-group"><input type="text" class="form-control" id=
					  "directory" /> <span class="input-group-btn"><button class="btn btn-default"
											       type="submit" id="btn-nav-directory"><span class="input-group-btn">Go!</span></button></span></div>
	</form>
      </div>
      <br />
      <div id="panel"></div>
      <div id="log"></div>
    </div>

    <script type="text/x-dust-template" id="tmpl-explorer">
      <table class="table">
        <thead>
          <tr>
            <th>Permission</th>
            <th>Owner</th>
            <th>Group</th>
            <th>Size</th>
            <th>Replication</th>
            <th>Block Size</th>
            <th>Name</th>
          </tr>
        </thead>
        <tbody>
          {#FileStatus}
          <tr>
            <td>{type|helper_to_directory}{permission|helper_to_permission}{aclBit|helper_to_acl_bit}</td>
            <td>{owner}</td>
            <td>{group}</td>
            <td>{length|fmt_bytes}</td>
            <td>{replication}</td>
            <td>{blockSize|fmt_bytes}</td>
            <td><a style="cursor:pointer" inode-type="{type}" class="explorer-browse-links" inode-path="{pathSuffix}">{pathSuffix}</a></td>
          </tr>
          {/FileStatus}
        </tbody>
      </table>
    </script>

    <script type="text/x-dust-template" id="tmpl-block-info">
      {#block}
      <p>Block ID: {blockId}</p>
      <p>Block Pool ID: {blockPoolId}</p>
      <p>Generation Stamp: {generationStamp}</p>
      <p>Size: {numBytes}</p>
      {/block}
      <p>Availability:
        <ul>
          {#locations}
          <li>{hostName}</li>
          {/locations}
        </ul>
      </p>
    </script>
    <script type="text/javascript" src="../js/dust-full-2.0.0.min.js">
    </script><script type="text/javascript" src="../js/dust-helpers-1.1.1.min.js">
    </script><script type="text/javascript" src="../js/dfs-dust.js">
    </script><script type="text/javascript" src="../js/explorer.js">
    </script>
<jsp:include page="footer.jsp" flush="true"></jsp:include>