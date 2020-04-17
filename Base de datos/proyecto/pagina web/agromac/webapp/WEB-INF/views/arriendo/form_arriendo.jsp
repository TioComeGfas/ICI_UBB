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
<spring:url value="/arriendo/save" var="urlSave" />

<meta
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"
	name="viewport">
<link rel="stylesheet"
	href="${urlPublic }/bower_components/bootstrap/dist/css/bootstrap.min.css">
<!-- Select 2 -->
<link rel="stylesheet"
	href="${urlPublic }/bower_components/select2/dist/css/select2.min.css">
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
	<jsp:include page="../include/head.jsp" />

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
				Recuerda:
				Al seleccionar sin operador, el sistema entendera que usara el encargado del cliente
			</div>	
			
			
			<!-- muestra los errores al usuario -->
			<spring:hasBindErrors name="arriendo">
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
				modelAttribute="arriendo" class="form-horizontal">
	
				<form:hidden path="id" />
				<form:hidden path="direccion.id" />
				<form:hidden path="cliente.id" />
				<form:hidden path="estado.id" />
				
				<section class="content-header">

					<div class="box box-info">
						<div class="box-header">
							<h3 class="box-title">
								<b>Registrar nueva maquinaria</b>
							</h3>
						</div>

						<div class="box-body">

							<span class="badge bg-navy">Informacion de contacto</span>
							<div class="form-group">
								<br /> <label for="inputNombre" class="col-sm-2 control-label">Fecha
									inicio</label>

								<div class="col-sm-10">
									<form:input path="fechaInicio" type="date"
										value="${arriendo.fechaInicio }" class="form-control"
										id="inputNombre" placeholder="Ingrese el nombre"
										requeried="true" />
								</div>
							</div>

							<div class="form-group">
								<label for="inputApellido1" class="col-sm-2 control-label">Fecha
									termino</label>

								<div class="col-sm-10">
									<form:input path="fechaTermino" type="date"
										value="${arriendo.fechaTermino }" class="form-control"
										id="inputApellido1" placeholder="Ingrese el apellido paterno"
										requeried="true" />
								</div>
							</div>

							<div class="form-group">
								<label for="inputApellido2" class="col-sm-2 control-label">Horas</label>

								<div class="col-sm-10">
									<form:input path="horasArriendo" type="number"
										value="${arriendo.horasArriendo }" class="form-control"
										id="inputApellido2"
										placeholder="Ingrese las horas de arriendo" requeried="requeried" />
								</div>
							</div>

							<span class="badge bg-navy">Direccion del arriendo</span>
							<div class="form-group">
								<br /> <label for="inputFecha" class="col-sm-2 control-label">Calle</label>

								<div class="col-sm-10">
									<form:input path="direccion.calle" type="text"
										value="${arriendo.direccion.calle }" class="form-control"
										id="inputFecha" requeried="true" />
								</div>
							</div>

							<div class="form-group">
								<label for="inputCiudad" class="col-sm-2 control-label">Ciudad</label>

								<div class="col-sm-10">
									<form:input path="direccion.ciudad" type="text"
										value="${arriendo.direccion.ciudad}" class="form-control"
										id="inputCiudad"
										placeholder=" Ingrese la ciudad del cliente"
										requeried="true" />
								</div>
							</div>

							<span class="badge bg-navy">Datos arriendo</span>

							<div class="form-group">
								<label for="inputCliente" class="col-sm-2 control-label">Cliente</label>

								<div class="col-sm-10">

									<form:select style="width: 100%;"
										path="idCliente" class="form-control select2"
										id="inputCliente">
										<option value="${cliente.id}" selected>${cliente.nombreCompleto}</option>
										<c:forEach items="${clientesS}" var="s" varStatus="status">
											<option value="${s.id}">${s.nombreCompleto}</option>
										</c:forEach>
									</form:select>
								</div>
							</div>

							<div class="form-group">
								<label for="inputOperador" class="col-sm-2 control-label">Operador</label>

								<div class="col-sm-10">

									<form:select style="width: 100%;" class="form-control select2" multiple="multiple"
										path="arrayOperadores" id="inputOperador">
										<c:forEach items="${operador}" var="s" varStatus="status">
											<option value="${s.id_empleado}" selected>${s.nombreCompleto}</option>
										</c:forEach>
										<c:forEach items="${operadoresS}" var="t" varStatus="status">
											<option value="${t.id_empleado}">${t.nombreCompleto}</option>
										</c:forEach>
									</form:select>
								</div>
							</div>

							<div class="form-group">
								<label for="inputMaq" class="col-sm-2 control-label">Maquinarias</label>

								<div class="col-sm-10">

									<form:select style="width: 100%;" multiple="multiple"
										class="form-control select2" path="arrayMaquinas" id="inputMaq">
										<c:forEach items="${maquina}" var="s" varStatus="status">
												<option value="${s.id}" selected>${s.marca} ${s.modelo}</option>
										</c:forEach>
										<c:forEach items="${maquinariasS}" var="s" varStatus="status">
											<option value="${s.id}">${s.marca} ${s.modelo}</option>
										</c:forEach>
									</form:select>
								</div>
							</div>

							<div class="form-group">
								<label for="inputEstado" class="col-sm-2 control-label">Estado</label>

								<div class="col-sm-10">

									<form:select class="form-control select2"
										path="estado.descripcion" id="inputEstado">
										<c:forEach items="${estadosS}" var="s" varStatus="status">
											<c:choose>
												<c:when test="${s eq estado.descripcion}">
													<option value="${s}" selected>${s}</option>
												</c:when>
												<c:otherwise>
													<option value="${s}">${s}</option>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</form:select>
								</div>
							</div>
						</div>
						<!-- /.box-body -->
						<div class="box-footer">
							<a href="${urlRoot}arriendo/general" role="button"
								class="btn btn-large btn-default">Volver</a>
							<button type="submit" class="btn btn-primary pull-right">Guardar</button>
						</div>
					</div>
				</section>
			</form:form>
		</section>
	</div>


	<!-- fragmento de footer -->
	<jsp:include page="../include/footer.jsp" />

	<!-- ./wrapper -->

	<!-- REQUIRED JS SCRIPTS -->

	<!-- jQuery 3 -->
	<script src="${urlPublic }/bower_components/jquery/dist/jquery.min.js"></script>
	<!-- select 2 -->
	<script
		src="${urlPublic }/bower_components/select2/dist/js/select2.full.min.js"></script>
	<!-- Bootstrap 3.3.7 -->
	<script
		src="${urlPublic }/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
	<!-- AdminLTE App -->
	<script src="${urlPublic }/dist/js/adminlte.min.js"></script>

	<script type="text/javascript">
		$(function() {
			$('.select2').select2()
		})
	</script>

</body>
</html>