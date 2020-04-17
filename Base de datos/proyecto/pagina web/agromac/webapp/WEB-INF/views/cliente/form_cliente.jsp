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
<spring:url value="/resources" var="urlPublic" />
<spring:url value="/" var="urlRoot" />
<spring:url value="/cliente/save" var="urlSave" />

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
	<jsp:include page="../include/head.jsp"/>

	<!-- contenido de cabezera -->
	<div class="content-wrapper">
		<section class="content-header">

			<!-- informacion de encargado -->
			<div class="alert alert-info alert-dismissible">
				<button type="button" class="close" data-dismiss="alert"
					aria-hidden="true">×</button>
				<h4>
					<i class="icon fa fa-info"></i> Informacion
				</h4>
				Si el cliente no posee encargado de faena solo deje en blanco el
				apartado "Informacion del Encargado"
			</div>

			<!-- muestra los errores al usuario -->
			<spring:hasBindErrors name="encargado">
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

		<!-- contenido del cuerpo -->
		<section class="content">

			<form:form action="${urlSave}" method="POST"
				modelAttribute="encargado" class="form-horizontal">
				
				<form:hidden path="cliente.id" />
				<form:hidden path="id" />
				<form:hidden path="cliente.tipoCliente.id" />
				<form:hidden path="cliente.direccion.id" />

				<section class="content-header">

					<div class="box box-info">
						<div class="box-header">
							<h3 class="box-title">
								<b>Registrar nuevo cliente</b>
							</h3>
						</div>

						<div class="box-body">

							<span class="badge bg-navy">Informacion del cliente</span>

							<div class="form-group">
								<br /> <label for="inputNombre" class="col-sm-2 control-label">Nombre</label>

								<div class="col-sm-10">
									<form:input path="cliente.nombre" type="text"
									value="${encargado.cliente.nombre }"
										class="form-control" id="inputNombre"
										placeholder="Ingrese el nombre" requeried="true" />
								</div>
							</div>

							<div class="form-group">
								<label for="inputApellido1" class="col-sm-2 control-label">Apellido
									Paterno</label>

								<div class="col-sm-10">
									<form:input path="cliente.apellido_p" type="text"
									value="${encargado.cliente.apellido_p }"
										class="form-control" id="inputApellido1"
										placeholder="Ingrese el apellido paterno" requeried="true" />
								</div>
							</div>

							<div class="form-group">
								<label for="inputApellido2" class="col-sm-2 control-label">Apellido
									Materno</label>

								<div class="col-sm-10">
									<form:input path="cliente.apellido_m" type="text"
									value="${encargado.cliente.apellido_m }"
										class="form-control" id="inputApellido2"
										placeholder="Ingrese el apellido materno" requeried="true" />
								</div>
							</div>

							<div class="form-group">
								<label for="inputFecha" class="col-sm-2 control-label">Nacimiento</label>

								<div class="col-sm-10">
									<form:input path="cliente.fecha_nacimiento" type="date"
									value="${encargado.cliente.fecha_nacimiento }"
										class="form-control" id="inputFecha" requeried="true" />
								</div>
							</div>

							<div class="form-group">
								<label for="inputFono" class="col-sm-2 control-label">Telefono</label>

								<div class="col-sm-10">
									<form:input path="cliente.telefono" type="number"
									value="${encargado.cliente.telefono }"
										class="form-control" id="inputFono"
										placeholder=" Ingrese el telefono de contacto"
										requeried="true" />
								</div>
							</div>

							<div class="form-group">
								<label for="inputRut" class="col-sm-2 control-label">Rut</label>

								<div class="col-sm-10">
									<form:input path="cliente.rut" type="text" class="form-control"
									value="${encargado.cliente.rut }"
										id="inputRut" placeholder="Rut" requeried="true" />
								</div>
							</div>
							<br /> <span class="badge bg-navy">Direccion del cliente</span>
							<div class="form-group">
								<br /> <label for="inputCalle" class="col-sm-2 control-label">Calle</label>

								<div class="col-sm-10">
									<form:input path="cliente.direccion.calle" type="text"
									value="${encargado.cliente.direccion.calle }"
										class="form-control" id="inputCalle" placeholder="Calle"
										requeried="true" />
								</div>
							</div>

							<div class="form-group">
								<label for="inputCiudad" class="col-sm-2 control-label">Ciudad</label>

								<div class="col-sm-10">
									<form:input path="cliente.direccion.ciudad" type="text"
									value="${encargado.cliente.direccion.ciudad }"
										class="form-control" id="inputCiudad" placeholder="Ciudad"
										requeried="true" />
								</div>
							</div>
							<br /> <span class="badge bg-navy">Informacion del
								Encargado (opcional)</span>
							<div class="form-group">
								<br /> <label for="inputNombre" class="col-sm-2 control-label">Nombre</label>

								<div class="col-sm-10">
									<form:input path="nombre" type="text" class="form-control"
										value="${encargado.nombre }" id="inputNombre"
										placeholder="Ingrese el nombre" />
								</div>
							</div>

							<div class="form-group">
								<label for="inputApellido3" class="col-sm-2 control-label">Apellido</label>

								<div class="col-sm-10">
									<form:input path="apellidoPaterno" type="text"
										value="${encargado.apellidoPaterno }" class="form-control"
										id="inputApellido3" placeholder="Ingrese el apellido paterno" />
								</div>
							</div>

							<div class="form-group">
								<label for="inputApellido4" class="col-sm-2 control-label">Apellido</label>

								<div class="col-sm-10">
									<form:input path="apellidoMaterno" type="text"
										value="${encargado.apellidoMaterno }" class="form-control"
										id="inputApellido4" placeholder="Ingrese el apellido materno" />
								</div>
							</div>

							<div class="form-group">
								<label for="inputFono2" class="col-sm-2 control-label">Telefono</label>

								<div class="col-sm-10">
									<form:input path="telefono" type="text" class="form-control"
										value="${encargado.telefono }" id="inputFono2"
										placeholder="Ingrese el telefono de contacto" />
								</div>
							</div>
						</div>
							<!-- /.box-body -->
							<div class="box-footer">

								<a href="${urlRoot}cliente/general" role="button"
									class="btn btn-large btn-default">Volver</a>
								<button type="submit" class="btn btn-primary pull-right">Guardar</button>
							</div>
							<!-- /.box-footer -->
					</div>
				</section>
			</form:form>
		</section>
	</div>

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

</body>
</html>