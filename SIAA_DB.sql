#!/usr/bin/ sql

""" 
Copyright (c) 2021-2030, SIAA, DB del sistema de horarios ITSAT (http://itsalamo.edu.mx/)
The only permissions are for the institution's staff, both the SQL code and the Database.
"""

--"""
--                     ##         .
--                ## ## ##        ==
--             ## ## ## ##       ===
--         /"""""""""""""""""\___/ ===
--    ~~~ {~~ ~~~~ ~~~ ~~~~ ~~~ ~ /  ===- ~~~
--         \______ X           __/
--           \    \         __/
--            \____\_______/
--                              DB_SIAA ITSAT - V1.0.5
--"""

DROP DATABASE IF EXISTS SIAA_DB;
CREATE DATABASE IF NOT EXISTS SIAA_DB;
USE SIAA_DB;

SELECT 'CREATING DATABASE STRUCTURE' as 'INFO';

/*Verificar si existen las siguientes tablas de la base de datos. */
DROP TABLE IF EXISTS datos_docente,
                     docente_horas,
                     datos_carrera,
                     datos_contenidos_carrera,
                     datos_carrera,
                     datos_edificio,
                     datos_salon_clases,
                     datos_periodo,
                     datos_hora,
                     datos_grupo,
                     datos_asignatura,
                     datos_plan_estudios,
                     datos_descarga,
                     datos_horas_periodo;

-- Tabla 1.
-- Tabla datos_docente.
CREATE TABLE datos_docente (
    -- id_docente. ↓
    id_1                        INT(8)          NOT NULL, -- ID asignado por sistema. 
    clave_servicios_escolares   CHAR(10)        NOT NULL, -- Clave departamento servicios escolares.
    nombre_docente              VARCHAR(25)     NOT NULL, -- Nombre del docente.
    apellido_docente            VARCHAR(25)     NOT NULL, -- Apellidos del docente.
    sexo_docente                ENUM ('M','F')  NOT NULL, -- Sexo del docente.
    perfil_docente              VARCHAR(25),              -- Perfil del docente.   
    descripcion_perfil_docente  VARCHAR(25),              -- Descripcion del perfil del docente.
    tipo_docente                VARCHAR(25),              -- Tipo de docente asignatura o asociado.
    clave_departamento          CHAR(10)        NOT NULL, -- Clave de departamento adscrito - (Datos contenidos carrera).
    clave_carrera               char(10),                 -- Clave de carrera adscrito - (Datos carrera).
    estado                      INT(8),                   -- Estado Activo o Inactivo.
    FOREIGN KEY (clave_departamento) REFERENCES datos_contenidos_carrera(clave_departamento),
    FOREIGN KEY (clave_carrera) REFERENCES datos_carrera(clave_carrera),
    PRIMARY KEY (id_1)
);

-- Tabla 2.
-- Tabla docente_horas.
CREATE TABLE docente_horas (
    -- id_docente_horas. ↓
    id_2                        INT(8)          NOT NULL, -- ID asignado por el sistema.
    docente_horas               INT(8),                   -- Horas del docente.
    -- id_periodo. ↓
    id_8                        INT(8),                   -- ID asignado por el sistema - (Datos periodo).  
    estado                      INT(8),                   -- Estado Activo o Inactivo.
    FOREIGN KEY (id_8) REFERENCES datos_periodo(id_8),
    PRIMARY KEY (id_2)
);

-- Tabla 3.
-- Tabla datos_carrera.
CREATE TABLE datos_carrera (
    -- id_datos_carrera. ↓
    id_3                        INT(8)          NOT NULL, -- ID asignado por el sistema.
    clave_carrera               CHAR(10)        NOT NULL, -- Clave de la carrera.
    nombre_carrera              VARCHAR(25)     NOT NULL, -- Nombre de la carrera.
    prefijo_carrera             VARCHAR(25)     NOT NULL, -- Nombre corto de la carrera.
    estado                      INT(8),                   -- Estado Activo o Inactivo.
    PRIMARY KEY (id_3)
);

-- Tabla 4.
-- Tabla datos_contenidos_carrera.
CREATE TABLE datos_contenidos_carrera (
    -- id_datos_contenidos_carrera. ↓
    id_4                        INT(8)          NOT NULL, -- ID asignado por el sistema.
    clave_departamento          CHAR(10)        NOT NULL, -- Clave del departamento. 
    nombre_departamento         VARCHAR(25)     NOT NULL, -- Nombre del departamento.
    prefijo_departamento        VARCHAR(25)     NOT NULL, -- Nombre corto del departamento.
    estado                      INT(8),                   -- Estado Activo o Inactivo.
    PRIMARY KEY (id_4)
);

-- Tabla 5.
-- Tabla datos_campus.
CREATE TABLE datos_campus (
    -- id_campus. ↓
    id_5                        INT(8)          NOT NULL, -- ID asignado por el sistema.
    clave_campus                CHAR(10)        NOT NULL, -- Clave del campus.
    nombre_campus               VARCHAR(25)     NOT NULL, -- Nombre del campus.
    PRIMARY KEY (id_5)
);

-- Tabla 6.
-- Tabla datos_edificio.
CREATE TABLE datos_edificio (
    -- id_edificio. ↓
    id_6                        INT(8)          NOT NULL, -- ID asignado por el sistema.
    clave_edificio              CHAR(10)        NOT NULL, -- Clave del edificio.
    nombre_edificio             VARCHAR(25)     NOT NULL, -- Nombre del edificio.
    cantidad_salones            INT(8),                   -- Cantidad de salones.
    -- id_campus. ↓
    id_5                        INT(8),                   -- ID asignado por el sistema - (Datos campus).    
    grafico_edificio            LONGBLOB        NOT NULL, -- Imagen del salon.
    FOREIGN KEY (id_5) REFERENCES datos_campus(id_5),
    PRIMARY KEY (id_6)
);

-- Tabla 7.
-- Tabla datos_salon_clases.
CREATE TABLE datos_salon_clases (
    -- id_datos_salon_clases. ↓
    id_7                        INT(8)          NOT NULL, -- ID asignado por el sistema. 
    clave_salon                 CHAR(10)        NOT NULL, -- Clave del salon.
    prefijo_salon               VARCHAR(25)     NOT NULL, -- Nombre corto del salon..
    tipo_salon                  VARCHAR(25),              -- Tipo de salon.
    capacidad_salon             INT(8),                   -- Capacidad maxima de alumnos por salon.
    clave_edificio              CHAR(10),                 -- Clave de edificio - (Datos edificio).
    estado                      INT(8),                   -- Estado Activo o Inactivo.
    FOREIGN KEY (clave_edificio) REFERENCES datos_edificio(clave_edificio),
    PRIMARY KEY (id_7)
);

-- Tabla 8.
-- Tabla datos_periodo.
CREATE TABLE datos_periodo (
    -- id_datosperiodo. ↓
    id_8                        INT(8)          NOT NULL, -- ID asignado por el sistema. 
    clave_periodo               CHAR(10)        NOT NULL, -- Clave del periodo.
    nombre_periodo              VARCHAR(25),              -- Nombre del periodo.  
    prefijo_periodo             VARCHAR(25)     NOT NULL, -- Nombre corto del periodo.
    fecha_inicio                DATE,                     -- Fecha de inicio.
    fecha_termino               DATE,                     -- Fecha de termino.  
    estado                      INT(8),                   -- Estado Activo o Inactivo.  
    PRIMARY KEY (id_8)
);

-- Tabla 9.
-- Tabla datos_hora.
CREATE TABLE datos_hora (
    -- id_datoshora. ↓
    id_9                        INT(8)          NOT NULL, -- ID asignado por el sistema.
    numero_hora                 INT(8)          NOT NULL, -- Numero posicion de hora.
    hora_inicio                 TIME            NOT NULL, -- Hora de inicio.
    hora_termino                TIME            NOT NULL, -- Hora de termino.
    minutos                     TIME            NOT NULL, -- Minutos.
    tipo_hora                   CHAR(10)        NOT NULL, -- Tipo de hora.
    turno                       VARCHAR(25),              -- Turno.  
    modalidad                   VARCHAR(25),              -- Modalidad.
    clave_campus                CHAR(10),                 -- Clave campus - (Datos campus).
    FOREIGN KEY (clave_campus) REFERENCES datos_campus(clave_campus),
    PRIMARY KEY (id_9)
);

-- Tabla 10.
-- Tabla datos_grupo.
CREATE TABLE datos_grupo (
    -- id_datos_grupo. ↓
    id_10                       INT(8)          NOT NULL, -- ID asignado por el sistema.
    clave_grupo                 CHAR(10)        NOT NULL, -- Clave del grupo.
    modalidad                   VARCHAR(25),              -- Modalidad - Escolarizado, Sabatino, Virtual.
    clave_carrera               CHAR(10)        NOT NULL, -- Clave carrera - (Datos carrera).
    clave_campus                CHAR(10)        NOT NULL, -- Clave campus - (Datos campus).
    clave_periodo               CHAR(10)        NOT NULL, -- Clave periodo - (Datos periodo).
    FOREIGN KEY (clave_carrera) REFERENCES datos_carrera(clave_carrera),
    FOREIGN KEY (clave_campus) REFERENCES datos_campus(clave_campus),
    FOREIGN KEY (clave_periodo) REFERENCES datos_periodo(clave_periodo),
    PRIMARY KEY (id_10)
);

-- Tabla 11.
-- Tabla datos_asignatura.
CREATE TABLE datos_asignatura (
    -- id_datos_asignatura. ↓
    id_11                       INT(8)          NOT NULL, -- ID asignado por el sistema.
    clave_asignatura            CHAR(10)        NOT NULL, -- Clade asignatura.
    nombre_asignatura           VARCHAR(25)     NOT NULL, -- Nombre de la asignatura. 
    prefijo_asignatura          VARCHAR(25)     NOT NULL, -- Nombre corto asignatura.
    horas_teoricas              INT(8)          NOT NULL, -- Horas teoricas.
    horas_practicas             INT(8)          NOT NULL, -- Horas practicas.
    creditos                    INT(8)          NOT NULL, -- Creditos.
    especialidad                BOOLEAN IN(TRUE,FALSE) NOT NULL, -- Especialidad.
    eje_asignatura              VARCHAR(25),              -- Eje de la asignatura.
    -- id_plan_estudios. ↓
    id_12                       INT(8),                   -- ID asignado por el sistema - (Datos plan estudios).  
    -- id_datos_carrera. ↓
    id_3                        INT(8)          NOT NULL, -- ID asignado por el sistema - (Datos carrera).
    semestre_asignatura         VARCHAR(25),              -- Semestre al que corresponde la asignatura.
    estado                      INT(8)          NOT NULL, -- Estado Activo o Inactivo.  
    FOREIGN KEY (id_12) REFERENCES datos_plan_estudios(id_12),
    FOREIGN KEY (id_3) REFERENCES datos_carrera(id_3),
    PRIMARY KEY (id_11)
);

-- Tabla 12.
-- Tabla datos_planestudio.
CREATE TABLE datos_plan_estudios (
    -- id_plan_estudios. ↓
    id_12                       INT(8)          NOT NULL, -- ID asignado por el sistema. 
    clave_plan_estudios         CHAR(10)        NOT NULL, -- Clave plan estudios.
    nombre_plan_estudios        VARCHAR(25)     NOT NULL, -- Nombre del plan de estudios.
    fecha_inicio                DATE,                     -- Fecha inicio.
    fecha_termino               DATE,                     -- Fecha termino.  
    clave_carrera               CHAR(10),                 -- Clave carrera - (Datos carrera).  
    estado                      INT(8),                   -- Estado Activo o Inactivo.    
    FOREIGN KEY (clave_carrera) REFERENCES datos_carrera(clave_carrera),
    PRIMARY KEY (id_12)
);

-- Tabla 13.
-- Tabla datos_descarga.
CREATE TABLE datos_descarga (
    -- id_datos_descarga. ↓
    id_13                       INT(8)          NOT NULL, -- ID asignado por el sistema.
    clave_descarga              CHAR(10)        NOT NULL, -- Clave descarga.
    nombre_descarga             VARCHAR(25)     NOT NULL, -- Nombre descarga.
    prefijo_descarga            VARCHAR(25),              -- Nombre corto descarga.  
    estado                      INT(8),                   -- Estado Activo o Inactivo.   
    PRIMARY KEY (id_13)
);

-- Tabla 14.
-- Tabla datos_horas_periodo.
CREATE TABLE datos_horas_periodo (
    -- id_datos_horas_periodo. ↓
    id_14                       INT(8)          NOT NULL, -- ID asignado por el sistema.
    -- id_docente. ↓
    id_1                        INT(8),                   -- ID asignado por el sistema - (Datos docente).  
    -- id_periodo. ↓
    id_8                        INT(8),                   -- ID asignado por el sistema - (Datos periodo). 
    th_horas                    INT(8),                   -- Total de horas.
    hfh_horas                   INT(8),                   -- Total de horas frente al grupo.  
    hd_horas_descarga           INT(8),                   -- Total de horas de descarga.  
    -- id_periodo. ↓
    -- id                          INT(8),
    estado                      INT(8),                   -- Estado Activo o Inactivo. 
    FOREIGN KEY (id_1) REFERENCES datos_docente(id_1),
    FOREIGN KEY (id_8) REFERENCES datos_periodo(id_8),
    PRIMARY KEY (id_14)
);