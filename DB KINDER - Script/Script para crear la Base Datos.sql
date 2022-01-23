/*==============================================================*/
/* Table: CALIFICACION                                          */
/*==============================================================*/
create table CALIFICACION (
   ID_CALIFICACION      INT                  not null,
   ID_MATRICULA         INT                  null,
   CALIFICACION         VARCHAR(40)          null,
   ESTADO_EST           VARCHAR(30)          null,
   constraint PK_CALIFICACION primary key (ID_CALIFICACION)
);



/*==============================================================*/
/* Table: ESTADO_MATRICULA                                      */
/*==============================================================*/
create table ESTADO_MATRICULA (
   ID_ESTADO_MATR       INT                  not null,
   ID_MATRICULA         INT                  null,
   ESTADO_MATRICULA     VARCHAR(50)          null,
   constraint PK_ESTADO_MATRICULA primary key (ID_ESTADO_MATR)
);



/*==============================================================*/
/* Table: ESTADO_SOCIAL_EDUCATIVO                               */
/*==============================================================*/
create table ESTADO_SOCIAL_EDUCATIVO (
   ID_EST               INT                  null,
   TALLA_VESTIMENTA     VARCHAR(10)          null,
   TALLA_ZAPATO         NUMERIC              null,
   ALERGIAS             VARCHAR(50)          null,
   MEDICAMENTOS_REGULARES VARCHAR(100)       null,
   ULTFECHA_ENFERMO     DATE                 null,
   DIAGNOSTICO          VARCHAR(100)         null,
   DOCTOR_TRATANTE      VARCHAR(50)          null
);



/*==============================================================*/
/* Table: ESTUDIANTE                                            */
/*==============================================================*/
create table ESTUDIANTE (
   ID_EST               INT                  not null,
   ID_REPRE             INT                  null,
   CI_EST               VARCHAR(15)          null,
   NOMBRES_EST          VARCHAR(40)          null,
   APELLIDOS_EST        VARCHAR(40)          null,
   GENERO_EST           VARCHAR(20)          null,
   NACIONALIDAD_EST     VARCHAR(20)          null,
   FECHA_NACIMIENTO     DATE                 null,
   NOMBRES_PADRE        VARCHAR(40)          null,
   APELLIDOS_PADRE      VARCHAR(40)          null,
   TELEFONO_PADRE       VARCHAR(15)          null,
   DOMICILIO_PADRE      VARCHAR(60)          null,
   NOMBRES_MADRE        VARCHAR(40)          null,
   APELLIDOS_MADRE      VARCHAR(40)          null,
   TELEFONO_MADRE       VARCHAR(15)          null,
   DOMICILIO_MADRE      VARCHAR(60)          null,
   constraint PK_ESTUDIANTE primary key (ID_EST)
);


/*==============================================================*/
/* Table: MATRICULA                                             */
/*==============================================================*/
create table MATRICULA (
   ID_MATRICULA         INT                  not null,
   ID_PERIODO           INT                  not null,
   ID_EST               INT                  null,
   VALOR_MATRICULA      MONEY                null,
   FECHA_MATRICULA      DATE                 null,
   ESTADO_CUENTA        VARCHAR(40)          null,
   VALOR_PENDIENDE_A_PAGAR MONEY                null,
   constraint PK_MATRICULA primary key (ID_MATRICULA)
);



/*==============================================================*/
/* Table: PAGO_MATRICULA                                        */
/*==============================================================*/
create table PAGO_MATRICULA (
   ID_PAGO              INT                  not null,
   ID_MATRICULA         INT                  null,
   PAGO_REALIZADO       MONEY                null,
   constraint PK_PAGO_MATRICULA primary key (ID_PAGO)
);



/*==============================================================*/
/* Table: PERIODO                                               */
/*==============================================================*/
create table PERIODO (
   ID_PERIODO           INT                  not null,
   FCH_FIN_PERIODO      DATE                 null,
   FCH_INICIO_PERIODO   DATE                 null,
   ANIO_LECTIVO         VARCHAR(15)          null,
   constraint PK_PERIODO primary key (ID_PERIODO)
);


/*==============================================================*/
/* Table: PROFESIONAL                                           */
/*==============================================================*/
create table PROFESIONAL (
   ID_PROF              INT                  not null,
   CI_PROF              VARCHAR(15)          null,
   NOMBRES_PROF         VARCHAR(40)          null,
   APELLIDOS_PROF       VARCHAR(40)          null,
   GENERO_PROF          VARCHAR(20)          null,
   NACIONALIDAD_PROF    VARCHAR(30)          null,
   DIRECCION_PROF       VARCHAR(100)         null,
   TELEFONO_PROF        VARCHAR(15)          null,
   NUM_CERTIFICADO_PROFECIONAL VARCHAR(20)          null,
   constraint PK_PROFESIONAL primary key (ID_PROF)
);



/*==============================================================*/
/* Table: PROGRAMA                                              */
/*==============================================================*/
create table PROGRAMA (
   ID_PROGRAMA          INT                  not null,
   NOMBRE_PROGRAMA      VARCHAR(50)          null,
   DESCRIPCION_ACTIVIDADES VARCHAR(100)      null,
   NUM_ACTIVIDADES      INT                  null,
   MATERIALES_A_USAR    VARCHAR(100)         null,
   DURACION_PROGRAMA    VARCHAR(100)         null,
   constraint PK_PROGRAMA primary key (ID_PROGRAMA)
);



/*==============================================================*/
/* Table: DETALLE_MATRICULA                                       */
/*==============================================================*/
create table DETALLE_MATRICULA (
   ID_PROGRAMA          INT                  not null,
   ID_PROF              INT                  null,
   ID_MATRICULA         INT                  not null,
   FECHA_INICIO_PROG    DATE                 null,
   FECHA_FIN_PROG       DATE                 null,
   ESTADO_PROG          VARCHAR(30)          null,
   constraint PK_DETALLE_MATRICULA primary key (ID_MATRICULA)
);



/*==============================================================*/
/* Table: TUTOR_REPRESENTANTE                                   */
/*==============================================================*/
create table TUTOR_REPRESENTANTE (
   ID_REPRE             INT                  not null,
   CI_REPRE             VARCHAR(15)          null,
   NOMBRES_REPRE        VARCHAR(40)          null,
   APELLIDOS_REPRE      VARCHAR(40)          null,
   GENERO_REPRE         VARCHAR(20)          null,
   NACIONALIDAD_REPRE   VARCHAR(30)          null,
   DIRECCION_REPRE      VARCHAR(100)         null,
   TELEFONO_REPRE       VARCHAR(15)          null,
   DOMICILIO_REPRE      VARCHAR(50)          null,
   constraint PK_TUTOR_REPRESENTANTE primary key (ID_REPRE)
);



alter table CALIFICACION
   add constraint FK_CALIFICA_RELATIONS_MATRICUL foreign key (ID_MATRICULA)
      references MATRICULA (ID_MATRICULA)
      on delete restrict on update restrict;

alter table ESTADO_MATRICULA
   add constraint FK_ESTADO_M_RELATIONS_MATRICUL foreign key (ID_MATRICULA)
      references MATRICULA (ID_MATRICULA)
      on delete restrict on update restrict;

alter table ESTADO_SOCIAL_EDUCATIVO
   add constraint FK_ESTADO_S_RELATIONS_ESTUDIAN foreign key (ID_EST)
      references ESTUDIANTE (ID_EST)
      on delete restrict on update restrict;

alter table ESTUDIANTE
   add constraint FK_ESTUDIAN_RELATIONS_TUTOR_RE foreign key (ID_REPRE)
      references TUTOR_REPRESENTANTE (ID_REPRE)
      on delete restrict on update restrict;

alter table MATRICULA
   add constraint FK_MATRICUL_RELATIONS_PERIODO foreign key (ID_PERIODO)
      references PERIODO (ID_PERIODO)
      on delete restrict on update restrict;

alter table MATRICULA
   add constraint FK_MATRICUL_RELATIONS_ESTUDIAN foreign key (ID_EST)
      references ESTUDIANTE (ID_EST)
      on delete restrict on update restrict;

alter table PAGO_MATRICULA
   add constraint FK_PAGO_MAT_RELATIONS_MATRICUL foreign key (ID_MATRICULA)
      references MATRICULA (ID_MATRICULA)
      on delete restrict on update restrict;

alter table DETALLE_MATRICULA
   add constraint FK_RELATION_RELATIONS_PROFESIO foreign key (ID_PROF)
      references PROFESIONAL (ID_PROF)
      on delete restrict on update restrict;

alter table DETALLE_MATRICULA
   add constraint FK_RELATION_RELATIONS_PROGRAMA foreign key (ID_PROGRAMA)
      references PROGRAMA (ID_PROGRAMA)
      on delete restrict on update restrict;

alter table DETALLE_MATRICULA
   add constraint FK_RELATION_RELATIONS_MATRICUL foreign key (ID_MATRICULA)
      references MATRICULA (ID_MATRICULA)
      on delete restrict on update restrict;


