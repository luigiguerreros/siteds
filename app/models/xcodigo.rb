class xcodigo
	attr_reader :arraysend2

	def initialize(asegurado_Codigo, asegurado_Producto, asegurado_Parentesco, asegurado_CodCliente)

		@asegurado_Codigo = asegurado_Codigo
		@asegurado_Producto = asegurado_Producto
		@asegurado_Parentesco = asegurado_Parentesco
		@asegurado_CodCliente = asegurado_CodCliente

		@eVinculada_Ruc = "20100054184"
		@eVinculada_Codigo = "980001C"
		@entidad_Codigo = "980002A"
		@wSSiteds_Version = "91"
		@strUserName = "40915788"
		@strPassword = "sitedsci"

		
		client = Savon.client(wsdl: 'http://servicios.susalud.gob.pe/wssiteds/wssiteds.asmx?wsdl')

		# call the 'get_consultax_codigo' operation
		response = client.call(:get_consultax_codigo,
			xml: "
				<soap:Envelope xmlns:soap='http://www.w3.org/2003/05/soap-envelope' xmlns:wss='http://www.seps.gob.pe/wssiteds'>
				<soap:Header>
				      <wss:AuthSoapHd>
				         <!--Optional:-->
				         <wss:strUserName>"+@strUserName+"</wss:strUserName>
				         <!--Optional:-->
				         <wss:strPassword>"+@strPassword+"</wss:strPassword>
				      </wss:AuthSoapHd>
				</soap:Header>
				<soap:Body>
				    <wss:GetConsultaxCodigo>
				         <!--Optional:-->
				         <wss:xmlRequest>
				            <GetConsultaxCodigo>
				               <Entidad_Codigo>"+@entidad_Codigo+"</Entidad_Codigo>
				               <EVinculada_Codigo>"+@eVinculada_Codigo+"</EVinculada_Codigo>
				               <EVinculada_Ruc>"+@eVinculada_Ruc+"</EVinculada_Ruc>
				               <Asegurado_Codigo>"+@asegurado_Codigo+"</Asegurado_Codigo>
				               <Asegurado_Producto>"+@asegurado_Producto+"</Asegurado_Producto>
				               <Asegurado_Parentesco>"+@asegurado_Parentesco+"</Asegurado_Parentesco>
				               <Asegurado_CodCliente>"+@asegurado_CodCliente+"</Asegurado_CodCliente>
				               <WSSiteds_Version>"+@wSSiteds_Version+"</WSSiteds_Version>
				            </GetConsultaxCodigo>
				         </wss:xmlRequest>
				      </wss:GetConsultaxCodigo>
				   </soap:Body>
				</soap:Envelope>
			")
		responsetxt = response.body[:get_consultax_codigo_response][:get_consultax_codigo_result]
		len = responsetxt.length
		cadena_cortada = responsetxt[0..5]

		codigo_error = cadena_cortada[0..2]

		cadena_limpia = responsetxt[6..len]
	end
end