<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>AGROMAQ</title>
<spring:url value="/resources" var="urlPublic" />
<!-- Tell the browser to be responsive to screen width -->
<meta
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"
	name="viewport">
<link rel="stylesheet"
	href="${urlPublic }/bower_components/bootstrap/dist/css/bootstrap.min.css">
<!-- Font Awesome -->
<link rel="stylesheet"
	href="${urlPublic }/bower_components/font-awesome/css/font-awesome.min.css">
<!-- Ionicons -->
<link rel="stylesheet"
	href="${urlPublic }/bower_components/Ionicons/css/ionicons.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="${urlPublic }/dist/css/AdminLTE.min.css">
<!-- Icon Style -->
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.5.0/css/all.css"
	integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU"
	crossorigin="anonymous">

<link rel="stylesheet"
	href="${urlPublic }/dist/css/skins/skin-blue.min.css">

<!-- Google Font -->
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
</head>

<body class="hold-transition skin-blue sidebar-mini">

	<!-- fragmento de barra lateral y barra superior -->
	<jsp:include page="../include/head.jsp"></jsp:include>

	<!-- Content Wrapper. Contains page content -->
	<div class="content-wrapper">
		<!-- Content Header (Page header) -->
		<section class="content-header">

			<div class="box box-solid box-danger">
				<div class="box-header with-border">
					<h3 class="box-title">
						<b>Tipo de mantenciones</b>
					</h3>
					<div class="box-tools pull-right">
						<a href="#createTipo" role="button"
							class="btn btn-large btn-danger" data-toggle="modal"><i
							class="fas fa-plus"></i></a>

					</div>
					<!-- /.box-tools -->
				</div>
				<!-- /.box-header -->
				<div class="box-body">
					<table class="table table-striped table-bordered">
						<thead>
							<tr>
								<th>Nombre</th>
								<th>Acciones</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${ mantencion }" var="mt">
								<tr>
									<td> ${mt.nombre}</td>
									<td> botones </td>
								</tr>
							</c:forEach>
						</tbody>	
					</table>
				</div>
				<!-- /.box-body -->
			</div>
			<!-- /.box -->
		</section>

		<!-- Modal HTML -->

		<!-- nuevo tipo -->
		<div id="createTipo" class="modal fade">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<h4 class="modal-title">Registrar Tipo</h4>
					</div>
					<div class="modal-body">

						<div class="input">
							<input type="text" class="form-control" placeholder="Nombre"
								aria-describedby="basic-addon1">
						</div>

					</div>
					<!-- end modal body -->
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
					<button onclick="launch_toast()" class="btn btn-primary"
						data-dismiss="modal">Guardar</button>
				</div>
			</div>
		</div>

		<!-- editar tipo -->
		<div id="editModal" class="modal fade">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<h4 class="modal-title">Editar Tipo</h4>
					</div>
					<div class="modal-body">

						<div class="input">
							<input type="text" class="form-control" placeholder="Nombre"
								aria-describedby="basic-addon1">
						</div>

					</div>
					<!-- end modal body -->
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
					<button onclick="launch_toast()" class="btn btn-primary"
						data-dismiss="modal">Guardar</button>
				</div>
			</div>
		</div>

		<!-- eliminar una mantencion -->
		<div id="delModal" class="modal fade">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<h4 class="modal-title">¿Esta seguro de borrar este elemento?</h4>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
						<button onclick="launch_toast2()" class="btn btn-danger"
							data-dismiss="modal">Eliminar</button>
					</div>
				</div>
			</div>
		</div>

		<!-- END MODAL HTML -->
	</div>
	<!-- /.content-wrapper -->

	<!-- fragmento de footer -->
	<jsp:include page="../include/footer.jsp"></jsp:include>

	<!-- ./wrapper -->

	<!-- REQUIRED JS SCRIPTS -->

	<!-- jQuery 3 -->
	<script src="${urlPublic }/bower_components/jquery/dist/jquery.min.js"></script>
	<!-- Bootstrap 3.3.7 -->
	<script
		src="${urlPublic }/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
	<!-- AdminLTE App -->
	<script src="${urlPublic }/dist/js/adminlte.min.js"></script>

	<!-- Optionally, you can add Slimscroll and FastClick plugins.
     Both of these plugins are recommended to enhance the
     user experience. -->
</body>
</html>
