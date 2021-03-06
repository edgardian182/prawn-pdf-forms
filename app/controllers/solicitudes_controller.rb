class SolicitudesController < ApplicationController

  def welcome
  end

  def create
    Client.generate(params_solicitud)

    pdf_form_amex = FormAmex.generar(params_solicitud)
    # pdf_credibanco = FormularioCredibanco.generar(params_solicitud)
    # pdf_redeban = FormularioRedeban.generar(params_solicitud)

    pdf_form_novedades = FormNovedades.generar(params_solicitud) #Creamos PDF Prawn
    pdf_form_certificacion_cuenta = FormCertificacionCuenta.generar(params_solicitud)
    pdf_form_credibanco = FormCredibanco.generar(params_solicitud)
    pdf_form_redeban = FormRedeban.generar(params_solicitud)

    pdf_combinado = CombinePDF.new
    # pdf_combinado << CombinePDF.load("solicitud-afiliacion-establecimientos-comercio.pdf")
    # pdf_combinado << CombinePDF.load("Formulario+de+afiliacion+RBM_agosto+2015.pdf")
    pdf_combinado << CombinePDF.load("F-1386 Solicitud de Afiliacion AMEX V4 2016.pdf")

    pdf_combinado << CombinePDF.load("F-1385-V2 Formato de Novedades Aceptación de Medios de Pago.pdf")
    pdf_combinado << CombinePDF.load("Certificación cuenta depósito Visa VHC02-FT07.pdf")
    pdf_combinado << CombinePDF.load("credibanco plano.pdf")
    pdf_combinado << CombinePDF.load("redeban plano.pdf")
    # pdf_combinado << CombinePDF.load("Formato Solicitud de Afiliacion Credibanco 2016 V23.pdf")
    # pdf_combinado << CombinePDF.load("Solicitud de afiliacion Redeban V5 2016 Editable.pdf")



    # pdf_combinado << CombinePDF.load("Solicitud de afiliacion Redeban V5 2016 Editable.pdf")


    # pdf_combinado.pages[0] << CombinePDF.parse(pdf_credibanco.render).pages[0]
    # pdf_combinado.pages[1] << CombinePDF.parse(pdf_credibanco.render).pages[1]
    # pdf_combinado.pages[2] << CombinePDF.parse(pdf_redeban.render).pages[0]
    # pdf_combinado.pages[3] << CombinePDF.parse(pdf_redeban.render).pages[1]
    pdf_combinado.pages[0] << CombinePDF.parse(pdf_form_amex.render).pages[0]
    pdf_combinado.pages[1] << CombinePDF.parse(pdf_form_amex.render).pages[1]

    pdf_combinado.pages[2] << CombinePDF.parse(pdf_form_novedades.render).pages[0]  # Express
    pdf_combinado.pages[3] << CombinePDF.parse(pdf_form_novedades.render).pages[1]  # Express

    pdf_combinado.pages[4] << CombinePDF.parse(pdf_form_certificacion_cuenta.render).pages[0]
    pdf_combinado.pages[5] << CombinePDF.parse(pdf_form_credibanco.render).pages[0]
    pdf_combinado.pages[6] << CombinePDF.parse(pdf_form_credibanco.render).pages[1]

    pdf_combinado.pages[7] << CombinePDF.parse(pdf_form_redeban.render).pages[0]
    pdf_combinado.pages[8] << CombinePDF.parse(pdf_form_redeban.render).pages[1]


    # pdf_combinado.pages[8] << CombinePDF.parse(pdf_form_redeban.render).pages[0]
    # pdf_combinado.pages[9] << CombinePDF.parse(pdf_form_redeban.render).pages[1]

    send_data pdf_combinado.to_pdf, filename: "solicitudes.pdf", type: "application/pdf"
  end

  def new
    @solicitud = Solicitud.new
    @solicitud.referencias_comerciales = []
    2.times do
      @solicitud.referencias_comerciales << Referencia.new
    end
    @solicitud.referencias_personales = []
    2.times do
      @solicitud.referencias_personales << Referencia.new
    end
    @solicitud.socios = []
    1.times do
      @solicitud.socios << Socio.new
    end
  end

  private

    def params_solicitud
      if !params[:solicitud][:ciudad_establecimiento].empty?
        city = City.find_by_city_name(params[:solicitud][:ciudad_establecimiento])
        params[:solicitud][:codigo_ciudad] = city.city_code
        params[:solicitud][:departamento_establecimiento] = city.department
        params[:solicitud][:codigo_departamento] = city.department_code

        # Mismos datos Correspondencia y Establecimiento
        params[:solicitud][:direccion_correspondencia] = params[:solicitud][:direccion_del_establecimiento]
        params[:solicitud][:telefono_correspondencia] = params[:solicitud][:telefono_del_establecimiento]
        params[:solicitud][:ciudad_correspondencia] = params[:solicitud][:ciudad_establecimiento]
        params[:solicitud][:departamento_correspondencia] = city.department
      else
        params[:solicitud][:codigo_ciudad] = ""
        params[:solicitud][:departamento_establecimiento] = ""
        params[:solicitud][:codigo_departamento] = ""
      end

      if params[:solicitud][:naturaleza] == "Natural"
        params[:solicitud][:socios_attributes]["0"][:nombres_y_apellidos] = params[:solicitud][:razon_social]
        params[:solicitud][:socios_attributes]["0"][:numero_documento] = params[:solicitud][:numero_documento_comercio]
        params[:solicitud][:socios_attributes]["0"][:direccion] = params[:solicitud][:direccion_residencia_rl]
        params[:solicitud][:socios_attributes]["0"][:ciudad] = params[:solicitud][:ciudad_residencia_rl]
        params[:solicitud][:socios_attributes]["0"][:telefono] = params[:solicitud][:telefono_rl]
        params[:solicitud][:socios_attributes]["0"][:celular] = params[:solicitud][:celular_rl]
        params[:solicitud][:socios_attributes]["0"][:correo_electronico] = params[:solicitud][:correo_electronico_rl]
        params[:solicitud][:socios_attributes]["0"][:tipo_documento] = params[:solicitud][:tipo_documento_comercio]
      end

      params.require(:solicitud).permit(:actividad_comercial,
                                        :administra_recursos_publicos_rl,
                                        :afiliado_a_otro_sistema,
                                        :agencia_de_viajes,
                                        :api,
                                        :boton_de_pagos,
                                        :cargo_rl,
                                        :celular,
                                        :celular_rl,
                                        :ciudad_correspondencia,
                                        :ciudad_establecimiento,
                                        :ciudad_expedicion_documento_rl,
                                        :ciudad_nacimiento_rl,
                                        :ciudad_residencia_rl,
                                        :codigo_banco,
                                        :codigo_ciiu,
                                        :codigo_ciudad,
                                        :codigo_departamento,
                                        :codigo_sucursal_banco,
                                        :codigo_unico,
                                        :comercio_principal_secundario_ta,
                                        :correo_electronico,
                                        :correo_electronico_rl,
                                        :departamento_correspondencia,
                                        :departamento_establecimiento,
                                        :departamento_nacimiento_rl,
                                        :digito_de_verificacion,
                                        :direccion_correspondencia,
                                        :direccion_del_establecimiento,
                                        :direccion_pagina_web,
                                        :direccion_residencia_rl,
                                        :egresos_mensuales,
                                        :estado_civil,
                                        :exento_de_retencion_de_ica,
                                        :exento_de_retencion_de_iva,
                                        :exento_de_retencion_en_la_fuente,
                                        :exportacion_oi,
                                        :facebook,
                                        :fax,
                                        :fecha_de_nacimiento_rl,
                                        :fecha_expedicion_documento_rl,
                                        :flickr,
                                        :foursquare,
                                        :goza_de_reconocimiento_publico_rl,
                                        :horario_atencion,
                                        :importacion_oi,
                                        :ingresos_mensuales,
                                        :ingresos_operacionales,
                                        :inversiones_oi,
                                        :linkedin,
                                        :mall_virtual,
                                        :mcc,
                                        :mi_pago_ta,
                                        :modulo_avanzado_cybersource,
                                        :modulo_basico_afs,
                                        :monto_estimado_mensual_oi,
                                        :multicomercio_ta,
                                        :naturaleza,
                                        :nit_cc,
                                        :nit_de_la_fiduciaria,
                                        :nombre_comercial,
                                        :nombre_del_banco,
                                        :nombre_en_redes,
                                        :nombres_rl,
                                        :numero_de_cuenta,
                                        :numero_de_matricula_mercantil,
                                        :numero_documento_comercio,
                                        :numero_documento_rl,
                                        :numero_iata_av,
                                        :operaciones_internacionales,
                                        :ostenta_algun_grado_de_poder_publico_rl,
                                        :otros_ingresos,
                                        :paga_cuentas,
                                        :pago_de_servicios_oi,
                                        :porcentaje_de_impuesto_al_consumo,
                                        :porcentaje_de_iva,
                                        :porcentaje_de_retefuente,
                                        :porcentaje_de_reteica,
                                        :posee_medio_de_acceso,
                                        :prestamos_oi,
                                        :primer_apellido_rl,
                                        :profesion_ocupacion_rl,
                                        :propietario_medio_acceso,
                                        :pse,
                                        :razon_social,
                                        :recurrente,
                                        {referencias_comerciales_attributes: [:celular,
                                                             :ciudad,
                                                             :correo_electronico,
                                                             :direccion,
                                                             :nombres_y_apellidos,
                                                             :numero_identificacion,
                                                             :telefono]},
                                        {referencias_personales_attributes: [:celular,
                                                             :ciudad,
                                                             :correo_electronico,
                                                             :direccion,
                                                             :nombres_y_apellidos,
                                                             :telefono]},
                                        :requiere_impuestos_av,
                                        :requiere_propina,
                                        :responsabilidad_tributaria,
                                        :segundo_apellido_rl,
                                        :sexo_rl,
                                        {socios_attributes: [:celular,
                                                             :ciudad,
                                                             :correo_electronico,
                                                             :direccion,
                                                             :nombres_y_apellidos,
                                                             :numero_documento,
                                                             :porcentaje_participacion,
                                                             :telefono,
                                                             :tipo_documento]},
                                        :telefono_correspondencia,
                                        :telefono_del_establecimiento,
                                        :telefono_rl,
                                        :tiene_matricula_mercantil,
                                        :tipo_de_afiliacion,
                                        :tipo_de_cuenta,
                                        :tipo_de_empresa,
                                        :tipo_de_establecimiento,
                                        :tipo_documento_comercio,
                                        :tipo_documento_rl,
                                        :tipo_medio_acceso,
                                        :tipo_profesion_rl,
                                        :titular_cuenta,
                                        :total_activos,
                                        :total_pasivos,
                                        :twitter,
                                        :venta_no_presencial,
                                        :venta_presencial_ta,
                                        :visa_distribucion,
                                        :web_de_pagos,
                                        :youtube)
    end

end
