SIERRAVP_DWH


CREATE DATABASE IF NOT EXISTS SIERRAVP_DWH;
USE SIERRAVP_DWH;

1. CREACIÓN DE TABLAS DE DIMENSIONES

-- Dimensión Alumno
CREATE TABLE Dim_Alumno (
    Alumno_SK INT AUTO_INCREMENT PRIMARY KEY,
    Codigo_Alumno INT NOT NULL,
    DNI INT,
    Nombres_Apellidos VARCHAR(255)
);

-- Dimensión Ubicación Académica (Jerarquía Facultad -> Escuela)
CREATE TABLE Dim_Ubicacion_Academica (
    Ubicacion_SK INT AUTO_INCREMENT PRIMARY KEY,
    Facultad_Nombre VARCHAR(255),
    Escuela_Profesional_Nombre VARCHAR(255)
);

-- Dimensión Curso
CREATE TABLE Dim_Curso (
    Curso_SK INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_Curso VARCHAR(255),
    Creditos INT
);

-- Dimensión Docente
CREATE TABLE Dim_Docente (
    Docente_SK INT AUTO_INCREMENT PRIMARY KEY,
    Profesor_ID INT NOT NULL
);

-- Dimensión Tiempo Académico Ejemplos: 2024-I, 2024-II
CREATE TABLE Dim_Tiempo_Academico (
    Tiempo_SK INT AUTO_INCREMENT PRIMARY KEY,
    Periodo_Academico VARCHAR(50) NOT NULL
);

2. CREACIÓN DE TABLAS DE HECHOS

CREATE TABLE Fact_Rendimiento_Academico (
    Alumno_SK INT NOT NULL,
    Ubicacion_SK INT NOT NULL,
    Curso_SK INT NOT NULL,
    Docente_SK INT NOT NULL,
    Tiempo_SK INT NOT NULL,
    
    Calificacion_Final DOUBLE,
    Valor_CRA DOUBLE,
    Posicion_Ranking INT,
    
    PRIMARY KEY (Alumno_SK, Curso_SK, Tiempo_SK),
    FOREIGN KEY (Alumno_SK) REFERENCES Dim_Alumno(Alumno_SK),
    FOREIGN KEY (Ubicacion_SK) REFERENCES Dim_Ubicacion_Academica(Ubicacion_SK),
    FOREIGN KEY (Curso_SK) REFERENCES Dim_Curso(Curso_SK),
    FOREIGN KEY (Docente_SK) REFERENCES Dim_Docente(Docente_SK),
    FOREIGN KEY (Tiempo_SK) REFERENCES Dim_Tiempo_Academico(Tiempo_SK)
);

CREATE TABLE Fact_Perfil_Estudiante (
    -- Llaves Foráneas (Dimensiones)
    Alumno_SK INT NOT NULL,
    Tiempo_SK INT NOT NULL,
    
    Score_Alegria INT,
    Score_Altruismo INT,
    Score_Amabilidad INT,
    Score_Ansias_Aventura INT,
    Score_Ansiedad INT,
    
    Nivel_Emprendimiento INT,
    Nivel_Investigacion INT,
    Nivel_Trabajo_Empresarial INT,
    Nivel_Voluntariado INT,
    
    PRIMARY KEY (Alumno_SK, Tiempo_SK),
    FOREIGN KEY (Alumno_SK) REFERENCES Dim_Alumno(Alumno_SK),
    FOREIGN KEY (Tiempo_SK) REFERENCES Dim_Tiempo_Academico(Tiempo_SK)
);

3. CREACIÓN DE ÍNDICES PARA OPTIMIZACIÓN

CREATE INDEX idx_fact_rendimiento_ubicacion ON Fact_Rendimiento_Academico(Ubicacion_SK);
CREATE INDEX idx_fact_rendimiento_curso ON Fact_Rendimiento_Academico(Curso_SK);
CREATE INDEX idx_fact_perfil_tiempo ON Fact_Perfil_Estudiante(Tiempo_SK);