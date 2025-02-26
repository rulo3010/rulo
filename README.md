# **Tarea 2: Proyección del precio de cierre del SP500 usando redes neuronales recurrentes**
* Luis Eduardo Sequeira 173870
* Victor Raúl Baños 159763

## **Descripción de la tarea**
El objetivo de esta tarea es construir un modelo basado en redes neuronales recurrentes utilizando Python, que sea capaz de pronosticar de forma efectiva el precio de cierre futuro del índice S&P500.

## **Especificaciones de la Tarea**

### **Dataset**
- Descargar de Yahoo finance las series de S&P, Dow Jones y el precio USD/MXN.
- Los datasets contiene precio de apertura, cierre, máximo y mínimo diario.

### **Objetivo**
- Entrenar una red recurrente que sea capaz de pronosticas correctamente los precios de cierre del índice S&P500.
---

## **Pasos necesarios para ejecutar el código**
**Paso 1: Importar librerías y descargar los datos**  
Se importaron las librerías necesarias para el análisis, necesarias para el entrenamiento de la red neuronal recurrente. Se uso una conexión con Yahoo finance para descargar los indices a estudias para la red neuronal. Una vez descargadas las series se realizó una grafica para ver la relación que tienen.
![download](https://github.com/user-attachments/assets/2d1deb55-e6b9-428c-8346-961d373f08a0)

Como podemos notar los indices S&P500 y Dow Jones tienen mucha relación ya que son empresas de Estados Unidos, y en especifico usaremos los precios de cierre.
Aplicaremos una normalización min-max para que sea nuestro input del modelo y la gráfica se ve de la siguiente forma:
![download](https://github.com/user-attachments/assets/c5c20f14-918a-4a0f-b01a-acf8d3348cd6)

**Paso 2: Definimos la ventana y creación de tensores**  
Se define una ventana de 15 días (quincenal) es decirl se van a seleccionar 15 datos de cierre de cada series para que sea nuestra infromación previa para predecir nuestro valor futuro, por ejemplo, se toman los primeros 15 valores del 2025 del S&P, Dow Jones y USD/MXN para pronosticar el valor 16 del 2025 de S&P.
Una vez definida la ventana, creamos tensores sobre nuestras observaciones de entrada y nuestra variables de respuesta y. Una vezz que desarrollamos lo anterios creamos nuestra base de entrenamiento (80% del total de la base) y nuestra base de prueba (20% del total de la base).

**Paso 3: Definir el modelo**  
Se definen las variables d entrada del modelo, como son el número de capaz ocultas, el criterio de pérdida u el optimizador e iniciamos el entrenamiento con 50 epocas. En esta primera ejecución llegamos a un error cuadadico medio (MSE) de 0.003915. La grafica de la predicción se ve de la siguiente forma:

![download](https://github.com/user-attachments/assets/f5f186d1-7981-407c-8ecb-4db5de17f841)

y mejorando el modelo y agregando nivel de confainza al 95% observamos que nuestra predicción se ve asi:

![download](https://github.com/user-attachments/assets/39f19424-d4ff-411e-9439-3299d7fb4fcd)




