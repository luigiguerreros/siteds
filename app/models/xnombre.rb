class Xnombre
	attr_reader :arraysend

	def initialize(nombres, a_paterno, a_materno)
		@nombres = nombres
		@a_paterno = a_paterno
		@a_materno = a_materno

		@eVinculada_Ruc = "20100054184"
		@eVinculada_Codigo = "980001C"
		
		# Rimac EPS (ya esta mapeado los campos)
		# @entidad_Codigo = "980002A"

		# Pacifico EPS*
		# @entidad_Codigo = "980004A"

		# Pacifico Seguros*
		@entidad_Codigo = "000003G"

		# Rimac Asistencia Medica (problemas: 101Error en Base de Datos del Servidor - EPS Host: 200.37.155.52)
		# @entidad_Codigo = "000005G"

		@wSSiteds_Version = "91"
		@strUserName = "40915788"
		@strPassword = "sitedsci"
		
		client = Savon.client(wsdl: 'http://servicios.susalud.gob.pe/wssiteds/wssiteds.asmx?wsdl', open_timeout: 100)
	
		# call the 'get_consultax_nombre' operation
		response = client.call(:get_consultax_nombre, 
			xml: "
				<soap:Envelope xmlns:soap='http://www.w3.org/2003/05/soap-envelope' xmlns:wss='http://www.seps.gob.pe/wssiteds'>
					<soap:Header>
						<wss:AuthSoapHd>
							<wss:strUserName>"+@strUserName+"</wss:strUserName>
							<wss:strPassword>"+@strPassword+"</wss:strPassword>
						</wss:AuthSoapHd>
					</soap:Header>

					<soap:Body>
						<wss:GetConsultaxNombre>
							<wss:xmlRequest>
								<GetConsultaxNombre>
									<Entidad_Codigo>"+@entidad_Codigo+"</Entidad_Codigo>
									<EVinculada_Codigo>"+@eVinculada_Codigo+"</EVinculada_Codigo>
									<EVinculada_Ruc>"+@eVinculada_Ruc+"</EVinculada_Ruc>
									<Asegurado_ApMaterno>"+@a_materno.to_s+"</Asegurado_ApMaterno>
									<Asegurado_ApPaterno>"+@a_paterno.to_s+"</Asegurado_ApPaterno>
									<Asegurado_Nombre>"+@nombres.to_s+"</Asegurado_Nombre>
									<WSSiteds_Version>"+@wSSiteds_Version+"</WSSiteds_Version>
								</GetConsultaxNombre>
							</wss:xmlRequest>
						</wss:GetConsultaxNombre>
					</soap:Body>
				</soap:Envelope>")

		#puts response.body
		responsetxt = response.body[:get_consultax_nombre_response][:get_consultax_nombre_result]
		len = responsetxt.length
		cadena_cortada = responsetxt[0..5]

		codigo_error = cadena_cortada[0..2]
		nro_registros = cadena_cortada[3..-1]

		cadena_limpia = responsetxt[6..len]
		cadena = []
		cadena = cadena_limpia.split("*")

		# Rimac EPS
		# @arraysend = cadena.each_slice(11).to_a

		# Pacifico EPS
		# @arraysend = cadena.each_slice(9).to_a

		# Pacifico Seguros
		@arraysend = cadena.each_slice(10).to_a

		# Rimac Asistencia Medica
		# @arraysend = cadena.each_slice(10).to_a

	end
end