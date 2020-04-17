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
<spring:url value="/" var="urlRoot" />

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

<link rel="stylesheet"
	href="${urlPublic }/bower_components/datatables.net-bs/css/dataTables.bootstrap.min.css">

<!-- Google Font -->
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
</head>

<body class="hold-transition skin-blue sidebar-mini">

	<!-- fragmento de barra lateral y barra superior -->
	<jsp:include page="../include/head.jsp"/>

	<!-- Content Wrapper. Contains page content -->
	<div class="content-wrapper">
		<!-- Content Header (Page header) -->
		<section class="content-header">

			<div class="box box-success">
				<div class="box-header">
					<h3 class="box-title">Empleados</h3>
				</div>
				<div class="box-body">

					<table id="tabla" class="table table-bordered table-hover">
						<thead>
							<tr>
								<th>Rut</th>
								<th>Nombre</th>
								<th>Telefono</th>
								<th>fecha de nacimiento</th>
								<th>tarifa</th>
								<th>Tipo</th>
								<th>Acciones</th>
							</tr>
						</thead>

						<tbody>
							<c:forEach items="${ emp }" var="em">
								<tr>
									<td>${em.rut}</td>
									<td>${em.nombreCompleto }</td>
									<td>${em.telefono}</td>
									<td><fmt:formatDate pattern="dd-MM-yyyy"
											value="${em.fecha_nacimiento}" /></td>
									<td>$ ${em.tarifa } /Hora</td>
									<c:choose>
										<c:when test="${em.tipo eq '1'}">
											<td><span class="label label-primary">Administrativo</span></td>
										</c:when>
										<c:when test="${em.tipo eq '2'}">
											<td><span class="label label-primary">Mecanico</span></td>
										</c:when>
										<c:otherwise>
											<td><span class="label label-primary">Operador</span></td>
										</c:otherwise>
									</c:choose>


									<td>
										<a href="${urlRoot}empleado/info?id_empleado=${em.id}"
										role="button" class="btn btn-large btn-primary"><i
											class="fas fa-eye"></i></a> 
										<a
										href="${urlRoot }empleado/editar?id_empleado=${em.id}"
										role="button" class="btn btn-large btn-primary"><i
											class="fas fa-edit"></i> </a> 
										<a role="button" href="${urlRoot }empleado/delete?id_empleado=${em.id}"
										onclick='return confirm("¿Esta seguro de eliminarlo, tambien se borrara todo lo relacionado ?")'
										class="btn btn-large btn-danger"><i class="fas fa-trash"></i>
									</a></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</section>
	</div>

	<!-- fragmento de footer -->
	<jsp:include page="../include/footer.jsp"></jsp:include>


	<!-- REQUIRED JS SCRIPTS -->

	<!-- jQuery 3 -->
	<script src="${urlPublic }/bower_components/jquery/dist/jquery.min.js"></script>

	<!-- Data table -->
	<script
		src="${urlPublic }/bower_components/datatables.net/js/jquery.dataTables.min.js"></script>
	<script
		src="${urlPublic }/bower_components/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>

	<!-- Bootstrap 3.3.7 -->
	<script
		src="${urlPublic }/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>

	<!-- SlimScroll -->
	<script
		src="${urlPublic }/bower_components/jquery-slimscroll/jquery.slimscroll.min.js"></script>
	<!-- FastClick -->
	<script src="${urlPublic }/bower_components/fastclick/lib/fastclick.js"></script>
	<!-- AdminLTE App -->
	<script src="${urlPublic }/dist/js/adminlte.min.js"></script>

	<script>
		$(function() {
			$('#tabla').DataTable({
				'paging' : true,
				'lengthChange' : false,
				'searching' : true,
				'ordering' : true,
				'info' : true,
				'autoWidth' : true
			})
		})
	</script>
</body>
</html>
