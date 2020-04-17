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
<spring:url value="/contrato/save" var="urlSave" />

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

			<form:form action="${urlSave}" method="POST" modelAttribute="contrato">
				
				<form:hidden path="id" />

				<section class="content-header">

					<div class="box box-info">
						<div class="box-header">
							<h3 class="box-title">
								<b>Registrar contrato</b>
							</h3>
						</div>
						<!-- /.box-header -->

						<div class="box-body">

							<div class="form-group">
								<br /> <label for="inputNombre" class="col-sm-2 control-label">Fecha inicio</label>

								<div class="col-sm-10">
									<form:input path="fechaInicio" type="date"
									value="${contrato.fechaInicio }"
										class="form-control" id="inputNombre"
										requeried="true" />
								</div>
							</div>

							<div class="form-group">
								<label for="inputApellido1" class="col-sm-2 control-label">Fecha termino</label>

								<div class="col-sm-10">
									<form:input path="fechaFin" type="date"
									value="${contrato.fechaFin }"
										class="form-control" id="inputApellido1"
										requeried="true" />
								</div>
							</div>

							<div class="form-group">
								<label for="inputApellido2" class="col-sm-2 control-label">Salario</label>

								<div class="col-sm-10">
									<form:input path="salario" type="text"
									value="${contrato.salario }"
										class="form-control" id="inputApellido2"
										placeholder="Ingrese el salario" requeried="true" />
								</div>
							</div>
							<!-- /.box-body -->
							<div class="box-footer">

								<a href="${urlRoot}contrato/general" role="button"
									class="btn btn-large btn-default">Volver</a>
								<button type="submit" class="btn btn-primary pull-right">Guardar</button>
							</div>
							<!-- /.box-footer -->
						</div>
					</div>


				</section>



			</form:form>

		</section>

	</div>
	<!-- /column 1 -->


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