<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>

<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>AGROMAQ</title>

<!-- ==================
 		EXPRESIONES
     ================== -->
<spring:url value="/resources" var="urlPublic" />
<spring:url value="/" var="urlRoot" />
<spring:url value="/empleado/save" var="urlSave" />

<meta
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"
	name="viewport">

<link rel="stylesheet"
	href="${urlPublic }/bower_components/bootstrap/dist/css/bootstrap.min.css">
<!-- Font Awesome -->
<link rel="stylesheet"
	href="${urlPublic }/bower_components/font-awesome/css/font-awesome.min.css">
<!-- Select 2 -->
<link rel="stylesheet"
	href="${urlPublic }/bower_components/select2/dist/css/select2.min.css">
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

	<div class="content-wrapper">
		<section class="content-header">

			<!-- muestra los errores al usuario -->
			<spring:hasBindErrors name="empleado">
				<div class='alert alert-danger' role='alert'>
					Por favor corrija los siguientes errores:
					<ul>
						<c:forEach var="error" items="${errors.allErrors}">
							<li><spring:message message="${error}" /></li>
						</c:forEach>
					</ul>
				</div>
			</spring:hasBindErrors>

		</section>

		<section class="content">

			<form:form action="${urlSave}" method="POST"
				modelAttribute="empleado" class="form-horizontal">
				
				<form:hidden path="id"/>
				<form:hidden path="contrato.id"/>
				<form:hidden path="direccion.id"/>

				<section class="content-header">

					<div class="box box-info">
						<div class="box-header">
							<h3 class="box-title">
								<b>Registrar nuevo empleado</b>
							</h3>
						</div>

						<div class="box-body">

							<span class="badge bg-navy">Informacion del empleado</span>

							<div class="form-group">
								<label for="inputNombre" class="col-sm-2 control-label">Nombre</label>

								<div class="col-sm-10">
									<form:input path="nombre" type="text"
										value="${empleado.nombre }" class="form-control"
										id="inputNombre" placeholder="Ingrese el nombre"
										requeried="true" />
								</div>
							</div>

							<div class="form-group">
								<label for="inputApellido1" class="col-sm-2 control-label">Apellido
									paterno</label>

								<div class="col-sm-10">
									<form:input path="apellido_p" type="text"
										value="${empleado.apellido_p }" class="form-control"
										id="inputApellido1" placeholder="Ingrese el apellido paterno"
										requeried="true" />
								</div>
							</div>

							<div class="form-group">
								<label for="inputApellido2" class="col-sm-2 control-label">Apellido
									materno</label>

								<div class="col-sm-10">
									<form:input path="apellido_m" type="text"
										value="${empleado.apellido_m }" class="form-control"
										id="inputApellido2" placeholder="Ingrese el apellido materno"
										requeried="true" />
								</div>
							</div>

							<div class="form-group">
								<label for="inputFono" class="col-sm-2 control-label">Telefono</label>

								<div class="col-sm-10">
									<form:input path="telefono" type="text" class="form-control"
										value="${empleado.telefono }" id="inputFono"
										placeholder="Ingrese el telefono" />
								</div>
							</div>

							<div class="form-group">
								<label for="inputFecha" class="col-sm-2 control-label">Fecha
									de nacimiento</label>

								<div class="col-sm-10">
									<form:input path="fecha_nacimiento" type="date"
										class="form-control" value="${empleado.fecha_nacimiento }"
										id="inputFecha" placeholder="Ingrese la fecha" />
								</div>
							</div>

							<div class="form-group">
								<label for="inputRut" class="col-sm-2 control-label">Rut</label>

								<div class="col-sm-10">
									<form:input path="rut" type="text" class="form-control"
										value="${empleado.rut }" id="inputFecha"
										placeholder="Ingrese el rut" />
								</div>
							</div>

							<div class="form-group">
								<label for="inputTarifa" class="col-sm-2 control-label">tarifa</label>

								<div class="col-sm-10">
									<form:input path="tarifa" type="text" class="form-control"
										value="${empleado.tarifa }" id="inputTarifa"
										placeholder="Ingrese la tarifa de horas extra" />
								</div>
							</div>

							<span class="badge bg-navy">Direccion del empleado</span>

							<div class="form-group">
								<label for="inputDir1" class="col-sm-2 control-label">Calle</label>

								<div class="col-sm-10">
									<form:input path="direccion.calle" type="text"
										value="${empleado.direccion.calle }" class="form-control"
										id="inputDir1" placeholder="Ingrese la calle" requeried="true" />
								</div>
							</div>

							<div class="form-group">
								<label for="inputDir2" class="col-sm-2 control-label">Ciudad</label>

								<div class="col-sm-10">
									<form:input path="direccion.ciudad" type="text"
										value="${empleado.direccion.ciudad }" class="form-control"
										id="inputDir2" placeholder="Ingrese ela ciudad"
										requeried="true" />
								</div>
							</div>

							<span class="badge bg-navy">Contrato del empleado</span>

							<div class="form-group">
								<label for="inputc1" class="col-sm-2 control-label">Fecha
									de inicio</label>

								<div class="col-sm-10">
									<form:input path="contrato.fechaInicio" type="date"
										value="${empleado.contrato.fechaInicio }" class="form-control"
										id="inputc1" placeholder="Ingrese la calle" requeried="true" />
								</div>
							</div>

							<div class="form-group">
								<label for="inputc2" class="col-sm-2 control-label">Fecha
									de termino</label>

								<div class="col-sm-10">
									<form:input path="contrato.fechaFin" type="date"
										value="${empleado.contrato.fechaFin }" class="form-control"
										id="inputc2" placeholder="Ingrese ela ciudad" requeried="true" />
								</div>
							</div>

							<div class="form-group">
								<label for="inputc3" class="col-sm-2 control-label">Salario</label>

								<div class="col-sm-10">
									<form:input path="contrato.salario" type="number"
										value="${empleado.contrato.salario }" class="form-control"
										id="inputc3" placeholder="Ingrese el salario" requeried="true" />
								</div>
							</div>

							<span class="badge bg-navy">Cargo del empleado</span>
							<div class="form-group">
								<label for="inputDir2" class="col-sm-2 control-label"></label>
								<div class="col-sm-10">
									<span> <form:radiobutton class="ocultar" path="tipo"
											value="1" /> Administrativo
									</span> <span> <form:radiobutton class="mostrar" path="tipo"
											value="2" /> Mecanico
									</span> <span> <form:radiobutton class="ocultar" path="tipo"
											value="3" /> Operador
									</span>
								</div>
							</div>


							<c:choose>
								<c:when test="${empleado.tipo eq '2'}">
									<div id="target">
										<span class="badge bg-navy">Especialidad del mecanico</span>
										<div class="form-group">
											<br /> <label for="inputEspecialidad"
												class="col-sm-2 control-label">Especialidad</label>

											<div class="col-sm-10">
												<form:input path="NombreEspecialidad" type="text"
													value="${especialidad.nombre }" class="form-control"
													id="inputEspecialidad"
													placeholder="Ingrese el nombre de la especialidad"
													requeried="true" />

											</div>
										</div>

										<div class="form-group">
											<label for="inputEspecialidad2"
												class="col-sm-2 control-label">Detalle</label>

											<div class="col-sm-10">

												<form:textarea path="detalleEspecialidad"
													class="form-control" rows="3"
													placeholder="Ingrese informacion detallada de la especialidad..."
													value="${especialidad.detalles}" id="inputEspecialidad2" />

											</div>
										</div>
									</div>
								</c:when>
								<c:otherwise>

									<div style="display: none;" id="target">
										<span class="badge bg-navy">Especialidad del mecanico</span>
										<div class="form-group">
											<br /> <label for="inputEspecialidad"
												class="col-sm-2 control-label">Especialidad</label>

											<div class="col-sm-10">
												<form:input path="NombreEspecialidad" type="text"
													value="${especialidad.nombre }" class="form-control"
													id="inputEspecialidad"
													placeholder="Ingrese el nombre de la especialidad"
													requeried="true" />

											</div>
										</div>

										<div class="form-group">
											<label for="inputEspecialidad2"
												class="col-sm-2 control-label">Detalle</label>

											<div class="col-sm-10">

												<form:textarea path="detalleEspecialidad"
													class="form-control" rows="3"
													placeholder="Ingrese informacion detallada de la especialidad..."
													value="${especialidad.detalles}" id="inputEspecialidad2" />

											</div>
										</div>
									</div>
								</c:otherwise>

							</c:choose>


						</div>
						<div class="box-footer">

							<a href="${urlRoot}empleado/general" role="button"
								class="btn btn-large btn-default">Volver</a>
							<button type="submit" class="btn btn-primary pull-right">Guardar</button>
						</div>
					</div>
				</section>
			</form:form>
		</section>
	</div>

	<!-- fragmento de footer -->
	<jsp:include page="../include/footer.jsp"></jsp:include>

	<!-- REQUIRED JS SCRIPTS -->

	<!-- jQuery 3 -->
	<script src="${urlPublic }/bower_components/jquery/dist/jquery.min.js"></script>
	<!-- Bootstrap 3.3.7 -->
	<script
		src="${urlPublic }/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
	<!-- select 2 -->
	<script
		src="${urlPublic }/bower_components/select2/dist/js/select2.full.min.js"></script>
	<!-- AdminLTE App -->
	<script src="${urlPublic }/dist/js/adminlte.min.js"></script>

	<script>
		$(document).ready(function() {
			$(".mostrar").on("click", function() {
				$('#target').show("swing"); //muestro mediante id
			});
			$(".ocultar").on("click", function() {
				$('#target').hide("swing"); //oculto mediante id
			});
		});
	</script>

	<script>
		$(function() {
			$('.select2').select2()
		})
	</script>

</body>
</html>