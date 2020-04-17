<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta charset="ISO-8859-1">
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
	href="${urlPublic }/dist/css/skins/skin-purple.min.css">
<!-- Google Font -->
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">

<link rel="stylesheet"
	href="${urlPublic }/bower_components/datatables.net-bs/css/dataTables.bootstrap.min.css">
</head>

<body class="hold-transition skin-purple sidebar-mini">

	<!-- fragmento de barra lateral y barra superior -->
	<jsp:include page="include/head.jsp"></jsp:include>

	<div class="content-wrapper">
		<section class="content-header"></section>

		<section class="content">

			<div class="modal fade" id="mostrarmodal" tabindex="-1" role="dialog"
				aria-labelledby="basicModal" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal"
								aria-hidden="true">&times;</button>
							<h3>Bienvenida a Agromac!!</h3>
						</div>
						<div class="modal-body">
						
							<h4 class="text-green"> Hola Maria Angelica Caro</h4>
							<p> Te damos una coordial bienvenida al sistema de Agromac</p>
							<p> a continuacion se muestra una serie de preguntas que te serviran para orientarte y comprender mejor que es lo que puedes hacer</p>
							<br /><br />
							<h4 class="text-light-blue">¿ Que puedo hacer ?</h4>
							<br />
							

							<ul>	
									<li><p class="text-muted">Visualizar y gestionar:</p>
									<ul>
										<li><p class="text-muted">arriendos que ah realizado un cliente</p></li>
										<li><p class="text-muted">arriendos y mantenciones que participó una maquinaria</p></li>
										<li><p class="text-muted">mantenciones que a realizado un mecanico</p></li>
										<li><p class="text-muted">arriendos que a participado un operador</p></li>
										<li><p class="text-muted">contrato de un empleado</p></li>
									</ul></li>	
																
								<li><p class="text-muted">Se puede registrar, modificar
										y eliminar:</p>
									<ul>
										<li><p class="text-muted">Clientes</p></li>
										<li><p class="text-muted">Maquinarias</p></li>
										<li><p class="text-muted">Mantenciones</p></li>
										<li><p class="text-muted">Contratos</p></li>
										<li><p class="text-muted">Arriendos</p></li>
										<li><p class="text-muted">Empleados</p></li>
									</ul></li>
							</ul>
							<br />
							<h4 class="text-light-blue">¿ Que tecnologia usaron ?</h4>
							<br />

							<ul>
								<li><p class="text-muted">Frontend:</p>
									<ul>
										<li><p class="text-muted">Boostrap</p></li>
										<li><p class="text-muted">Jquery</p></li>
										<li><p class="text-muted">JavaScript</p></li>
										<li><p class="text-muted">Css3</p></li>
										<li><p class="text-muted">Html5</p></li>
										<li><p class="text-muted">Ionicons</p></li>
										<li><p class="text-muted">Scss</p></li>
										<li><p class="text-muted">Entre otros</p></li>
									</ul></li>
							</ul>
							<br />

							<ul>
								<li><p class="text-muted">Backend:</p>
									<ul>
										<li><p class="text-muted">Spring</p></li>
										<li><p class="text-muted">Hibernate</p></li>
										<li><p class="text-muted">Java</p></li>
										<li><p class="text-muted">Pivotal</p></li>
										<li><p class="text-muted">Entre otros</p></li>
									</ul></li>
							</ul>
							<br />

							<h4 class="text-light-blue">¿ Quienes desarrollaron el
								sistema ?</h4>
							<br />


							<!-- PRESENTACION CAMILA -->
							<div class="box box-widget widget-user">
								<div class="widget-user-header bg-purple-active">
									<h3 class="widget-user-username">Camila Andrea Martinez Soto</h3>
									<h5 class="widget-user-desc">Diseño e implementacion del
										Front-end</h5>
								</div>
								<div class="widget-user-image">
									<img class="img-circle" src="${urlPublic}/dist/img/cami.jpg"
										alt="User Avatar">
								</div>
								<div class="box-footer">
									<div class="row">
										<div class="col-sm-4 border-right">
											<div class="description-block">
												<h5 class="description-header">19.798.217-9</h5>
												<span class="description-text">RUT</span>
											</div>
										</div>
										<div class="col-sm-4 border-right">
											<div class="description-block">
												<h5 class="description-header">camila.martinez1601@
													alumnos.ubiobio.cl</h5>
												<span class="description-text">CORREO</span>
											</div>
										</div>
										<!-- /.col -->
										<div class="col-sm-4">
											<div class="description-block">
												<h5 class="description-header">20</h5>
												<span class="description-text">EDAD</span>
											</div>
										</div>
									</div>
								</div>
							</div>
							<br />

							<!-- PRESENTACION ALAN -->
							<div class="box box-widget widget-user">
								<div class="widget-user-header bg-aqua-active">
									<h3 class="widget-user-username">Alan Andy Moreno Pando</h3>
									<h5 class="widget-user-desc">Diseño e implementacion del
										Front-end</h5>
								</div>
								<div class="widget-user-image">
									<img class="img-circle" src="${urlPublic}/dist/img/alan.jpg"
										alt="User Avatar">
								</div>
								<div class="box-footer">
									<div class="row">
										<div class="col-sm-4 border-right">
											<div class="description-block">
												<h5 class="description-header">19.414.709-0</h5>
												<span class="description-text">RUT</span>
											</div>
										</div>
										<div class="col-sm-4 border-right">
											<div class="description-block">
												<h5 class="description-header">alan.moreno1601@
													alumnos.ubiobio.cl</h5>
												<span class="description-text">CORREO</span>
											</div>
										</div>
										<div class="col-sm-4">
											<div class="description-block">
												<h5 class="description-header">22</h5>
												<span class="description-text">EDAD</span>
											</div>
										</div>
									</div>
								</div>
							</div>
							<br />
							
							<!-- PRESENTACION MIA -->
							<div class="box box-widget widget-user">
								<div class="widget-user-header bg-green-active">
									<h3 class="widget-user-username">Fredy Camilo Moncada Contreras</h3>
									<h5 class="widget-user-desc">Diseño e implementacion del
										Back-end</h5>
								</div>
								<div class="widget-user-image">
									<img class="img-circle" src="${urlPublic}/dist/img/yo.jpg"
										alt="User Avatar">
								</div>
								<div class="box-footer">
									<div class="row">
										<div class="col-sm-4 border-right">
											<div class="description-block">
												<h5 class="description-header">19.946.080-3</h5>
												<span class="description-text">RUT</span>
											</div>
										</div>
										<div class="col-sm-4 border-right">
											<div class="description-block">
												<h5 class="description-header">fredy.moncada1601@
													alumnos.ubiobio.cl</h5>
												<span class="description-text">CORREO</span>
											</div>
										</div>
										<div class="col-sm-4">
											<div class="description-block">
												<h5 class="description-header">20</h5>
												<span class="description-text">EDAD</span>
											</div>
										</div>
									</div>
								</div>
							</div>
							
							<br />
							<!--  
							<h4 class="text-red"> Funciones que quedaron pendientes </h4>
							
							<br />
							-->

						</div>
						<div class="modal-footer">
							<a href="#" data-dismiss="modal" class="btn btn-primary">Aceptar</a>
						</div>
					</div>
				</div>
			</div>



		</section>

	</div>

	<!-- fragmento de footer -->
	<jsp:include page="include/footer.jsp"></jsp:include>

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

	<script>
		$(document).ready(function() {
			$("#mostrarmodal").modal("show");
		});
	</script>

</body>
</html>