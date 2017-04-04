class Solicitud
  include ActiveModel::Model
  extend ActiveModel::Translation

  attr_accessor :actividad_comercial,
    :administra_recursos_publicos_rl,
    :afiliado_a_otro_sistema,
    :agencia_de_viajes,
    :api,
    :autorizacion_sms_credibanco,
    :boton_de_pagos,
    :cargo_rl,
    :celular,
    :celular_rl,
    :ciudad_correspondencia,
    :ciudad_establecimiento,      # ---------------------
    :ciudad_expedicion_documento_rl,
    :ciudad_nacimiento_rl,
    :ciudad_radicacion,
    :ciudad_residencia_rl,
    :codigo_banco,
    :codigo_ciiu,
    :codigo_ciudad,             # ---------------------
    :codigo_departamento,       # ---------------------
    :codigo_principal_ta,
    :codigo_sucursal_banco,
    :codigo_unico,
    :comercio_principal_secundario_ta,
    :correo_electronico,
    :correo_electronico_rl,
    :fecha,
    :departamento_correspondencia,
    :departamento_establecimiento, # ---------------------
    :departamento_nacimiento_rl,
    :digito_de_verificacion,
    :direccion_correspondencia,
    :direccion_del_establecimiento,
    :direccion_pagina_web,
    :direccion_residencia_rl,
    :egresos_mensuales,
    :es_aerolinea,
    :estado_civil,
    :exento_de_retencion_de_ica,
    :exento_de_retencion_de_iva,
    :exento_de_retencion_en_la_fuente,
    :exportacion_oi,
    :facebook,
    :fax,
    :fecha_de_nacimiento_rl,
    :fecha_diligenciamiento,
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
    :nombre_en_redes,
    :numero_de_cuenta,
    :nombre_del_banco,
    :nombres_rl,
    :numero_documento_comercio,
    :numero_documento_rl,
    :numero_iata_av,
    :numero_de_matricula_mercantil,
    :operaciones_internacionales,
    :ostenta_algun_grado_de_poder_publico_rl,
    :otros_ingresos,
    :paga_cuentas,
    :pago_de_servicios_oi,
    :porcentaje_de_iva,
    :porcentaje_de_retefuente,
    :porcentaje_de_reteica,
    :porcentaje_de_impuesto_al_consumo,
    :posee_medio_de_acceso,
    :prestamos_oi,
    :primer_apellido_rl,
    :profesion_ocupacion_rl,
    :propietario_medio_acceso,
    :pse,
    :razon_social,
    :recurrente,
    :redes_sociales,
    :referencias_comerciales,
    :referencias_personales,
    :requiere_impuestos_av,
    :requiere_propina,
    :responsabilidad_tributaria,
    :segundo_apellido_rl,
    :sexo_rl,
    :socios,
    :telefono_correspondencia,
    :telefono_del_establecimiento,
    :telefono_rl,
    :tiene_matricula_mercantil,
    :tipo_de_afiliacion,
    :tipo_de_cuenta,
    :tipo_de_operaciones_internacionales,
    :tipo_documento_comercio,
    :tipo_documento_rl,
    :tipo_de_empresa,
    :tipo_de_establecimiento,
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
    :youtube

    def referencias_comerciales_attributes=(attributes)
      logger.info "REFERENCIAS COMERCIALES PARAMETROS DESCONOCIDOS #{attributes}"
    end

    def referencias_personales_attributes=(attributes)
      logger.info "REFERENCIAS PERSONALES PARAMETROS DESCONOCIDOS #{attributes}"
    end

    def socios_attributes=(attributes)
      logger.info "SOCIOS PARAMETROS DESCONOCIDOS #{attributes}"
    end
end
