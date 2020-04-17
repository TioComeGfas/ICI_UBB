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

<!-- Google Font -->
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">

<link rel="stylesheet"
	href="${urlPublic }/bower_components/datatables.net-bs/css/dataTables.bootstrap.min.css">
</head>

<body class="hold-transition skin-blue sidebar-mini">

	<!-- fragmento de barra lateral y barra superior -->
	<jsp:include page="../include/head.jsp" />

	<!-- contenido de cabezera -->
	<div class="content-wrapper">

		<!-- contenido del cuerpo -->
		<section class="content">

			<section class="content-header">

				<div class="box box-solid">
					<div class="box-header">
						<h3 class="box-title">Informacion Importante</h3>
					</div>
					<!-- /.box-header -->
					<div class="box-body">
						<div class="box-group" id="accordion">
							<div class="panel box box-primary">
								<div class="box-header with-border">
									<h4 class="box-title">
										<a data-toggle="collapse" data-parent="#accordion"
											href="#collapseOne" aria-expanded="false" class="collapsed">
											Cliente </a>
									</h4>
								</div>
								<div id="collapseOne" class="panel-collapse collapse"
									aria-expanded="true" style="height: 0px;">
									<div class="box-body">
										<dl class="dl-horizontal">
											<dt>Nombre Cliente:</dt>
											<dd>${arriendo.cliente.nombreCompleto }</dd>
											<dt>Contacto:</dt>
											<dd>${arriendo.cliente.telefono}</dd>
											<c:choose>
												<c:when test="${encargado.nombre eq ''}" />
												<c:otherwise>
													<dt>Nombre Encargado:</dt>
													<dd>${encargado.nombreCompleto }</dd>
													<dt>Contacto:</dt>
													<dd>${encargado.telefono }</dd>
												</c:otherwise>
											</c:choose>
										</dl>
									</div>
								</div>
							</div>
							<div class="panel box box-danger">
								<div class="box-header with-border">
									<h4 class="box-title">
										<a data-toggle="collapse" data-parent="#accordion"
											href="#collapseTwo" class="" aria-expanded="true">
											Arriendo </a>
									</h4>
								</div>
								<div id="collapseTwo" class="panel-collapse collapse in"
									aria-expanded="false" style="">
									<div class="box-body">
										<dl class="dl-horizontal">
											<dt> Direccion:</dt>
											<dd>${arriendo.direccion.calle}, ${arriendo.direccion.ciudad}</dd>
											<dt> Estado:</dt>
											<dd>${arriendo.estado.descripcion}</dd>
											<dt> Horas arrendadas:</dt>
											<dd>${arriendo.horasArriendo}</dd>
											<dt> Costo total:</dt>
											<dd>$ ${totalArr}</dd>
										</dl>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>

				<!-- maquinarias en arriendo -->
				<div class="box box-success">
					<div class="box-header">
						<h3 class="box-title">Maquinarias registradas</h3>
					</div>
					<div class="box-body">

						<table id="tabla" class="table table-bordered table-hover">
							<thead>
								<tr>
									<th>Maquinaria</th>
									<th>Patente</th>
									<th>Valor por hora</th>
									<th>Tipo</th>
									<th>Acciones</th>
								</tr>
							</thead>

							<tbody>
								<c:forEach items="${ maquinarias }" var="maq">
									<tr>
										<td>${maq.marca }-${maq.modelo }</td>
										<td>${maq.patente }</td>
										<td>$ ${maq.valorPorHora}</td>
										<td>${maq.tipoMaquinaria.nombre}
										<td><a
											href="${urlRoot }maquinaria/info?id_maquinaria=${maq.id}"
											role="button" class="btn btn-large btn-primary"><i
												class="fas fa-eye"></i></a> <a
											href="${urlRoot }maquinaria/editar?id_maquinaria=${maq.id}"
											role="button" class="btn btn-large btn-primary"
											data-toggle="modal"> <i class="fas fa-edit"></i></a></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						
						<p>Costo total: <span class="badge bg-navy">$ ${totalMaq} </span></p>
						
					</div>
					<div class="box-footer">
						<a href="${urlRoot}cliente/general" role="button"
							class="btn btn-large btn-primary">Volver</a>
					</div>
				</div>


				<!-- operadores en arriendo -->
				<div class="box box-success">
					<div class="box-header">
						<h3 class="box-title">Operadores registradas</h3>
					</div>
					<div class="box-body">
						<table id="tabla2" class="table table-bordered table-hover">
							<thead>
								<tr>
									<th>Nombre</th>
									<th>valor</th>
									<th>Telefono</th>
									<th>Acciones</th>
								</tr>
							</thead>

							<tbody>
								<c:forEach items="${ operadores }" var="ope">
									<tr>
										<td>${ope.nombreCompleto }</td>
										<td>$ ${ope.tarifa }</td>
										<td>${ope.telefono}</td>
										<td><a
											href="${urlRoot}empleado/info?id_empleado=${ope.id_empleado}"
											role="button" class="btn btn-large btn-primary"><i
												class="fas fa-eye"></i></a> <a
											href="${urlRoot }empleado/editar?id_empleado=${ope.id_empleado}"
											role="button" class="btn btn-large btn-primary"><i
												class="fas fa-edit"></i> </a></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						
						<p>Costo total: <span class="badge bg-navy">$ ${totalOpe} </span></p>
					</div>
					<div class="box-footer">
						<a href="${urlRoot}cliente/general" role="button"
							class="btn btn-large btn-primary">Volver</a>
					</div>
				</div>
			</section>
		</section>
	</div>


	<!-- footer -->
	<jsp:include page="../include/footer.jsp"></jsp:include>

	<!-- JS SCRIPTS -->

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

	<!-- script para la tabla -->
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
			$('#tabla2').DataTable({
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