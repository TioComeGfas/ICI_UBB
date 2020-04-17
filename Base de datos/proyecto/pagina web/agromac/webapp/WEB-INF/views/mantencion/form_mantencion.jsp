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
<spring:url value="/mantencion/save" var="urlSave" />

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
<!-- Select 2 -->
<link rel="stylesheet"
	href="${urlPublic }/bower_components/select2/dist/css/select2.min.css">
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

			<!-- muestra los errores al usuario -->
			<spring:hasBindErrors name="mantencion">
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
				modelAttribute="mantencion" class="form-horizontal">

				<section class="content-header">
 
					<form:hidden path="id" />
					<form:hidden path="maquinaria.id" />
					<form:hidden path="mecanico.id_empleado" />
					<form:hidden path="tipoMantencion.id" />
					
					<div class="box box-info">
						<div class="box-header">
							<h3 class="box-title">
								<b>Gestionar Mantencion</b>
							</h3>
						</div>

						<div class="box-body">

							<span class="badge bg-navy">Informacion mantencion</span>

							<div class="form-group">
								<br /> <label for="inputNombre" class="col-sm-2 control-label">Fecha</label>

								<div class="col-sm-10">
									<form:input path="fecha" type="date" value="${man.fecha}"
										class="form-control" id="inputNombre"
										placeholder="Ingrese la fecha" requeried="true" />
								</div>
							</div>

							<div class="form-group">
								<label for="inputApellido1" class="col-sm-2 control-label">horas
									Trabajo</label>

								<div class="col-sm-10">
									<form:input path="horasTrabajadas" type="number"
										value="${man.horasTrabajadas }" class="form-control"
										id="inputApellido1"
										placeholder="Ingrese las horas en que se realizo la mantencion"
										requeried="true" />
								</div>
							</div>

							<div class="form-group">
								<label for="inputApellido2" class="col-sm-2 control-label">Maquinaria</label>

								<div class="col-sm-10">
									<form:select style="width: 100%;" path="idMaquina"
										class="form-control select2" id="inputApellido2"
										value="${man.maquinaria.id}">
										<c:forEach items="${maquinarias}" var="s" varStatus="status">
											<c:choose>
												<c:when test="${s.id eq man.maquinaria.id}">
													<option value="${s.id}" selected>${s.marca}-${s.modelo}</option>
												</c:when>
												<c:otherwise>
													<option value="${s.id}">${s.marca}-${s.modelo}</option>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</form:select>
								</div>
							</div>

							<div class="form-group">
								<label for="inputFecha" class="col-sm-2 control-label">Mecanico</label>

								<div class="col-sm-10">
									<form:select style="width: 100%;" path="idMecanico"
										class="form-control select2" id="inputFecha"
										value="${man.mecanico.id_empleado}">
										<c:forEach items="${mecanicos}" var="s" varStatus="status">
											<c:choose>
												<c:when test="${s.id_empleado eq man.mecanico.id_empleado}">
													<option value="${s.id_empleado}" selected>
														${s.nombreCompleto}</option>
												</c:when>
												<c:otherwise>
													<option value="${s.id_empleado}">${s.nombreCompleto}</option>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</form:select>
								</div>
							</div>

							<div class="form-group">
								<label for="inputFono" class="col-sm-2 control-label">Tipo
									de mantencion</label>

								<div class="col-sm-10">
									<form:select style="width: 100%;" path="idTipo"
										class="form-control select2" id="inputFono"
										value="${man.tipoMantencion.id}">
										<c:forEach items="${tipos}" var="s" varStatus="status">
											<c:choose>
												<c:when test="${s.id eq man.tipoMantencion.id}">
													<option value="${s.id}" selected>${s.nombre}</option>
												</c:when>
												<c:otherwise>
													<option value="${s.id}">${s.nombre}</option>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</form:select>
								</div>
							</div>

							<div class="form-group">
								<label for="input5" class="col-sm-2 control-label">Detalles</label>

								<div class="col-sm-10">
									<form:input path="descripcion" value="${man.descripcion }"
										class="form-control" id="input5"
										placeholder="Ingrese los detalles realizados en la mantencion" />
								</div>
							</div>

						</div>
						<!-- /.box-body -->
						<div class="box-footer">

							<a href="${urlRoot}mantencion/general" role="button"
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
	<!-- select 2 -->
	<script
		src="${urlPublic }/bower_components/select2/dist/js/select2.full.min.js"></script>
	<!-- Bootstrap 3.3.7 -->
	<script
		src="${urlPublic }/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
	<!-- AdminLTE App -->
	<script src="${urlPublic }/dist/js/adminlte.min.js"></script>

	<script>
		$(function() {
			$('.select2').select2()
		})
	</script>

</body>
</html>