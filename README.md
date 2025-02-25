# **Tarea 2: Proyección del precio de cierre del SP500 usando redes neuronales recurrentes**
* Luis Eduardo Sequeira 173870
* Victor Raúl Baños 159763

## **Descripción de la tarea**
El objetivo de esta tarea es construir un modelo basado en redes neuronales recurrentes utilizando Python, que sea capaz de pronosticar de forma efectiva el precio de cierre futuro del índice S&P500.

## **Especificaciones de la Tarea**

### **Dataset**
- Descargar de Yahoo finance las series de S&P, Dow Jones y el precio USD/MXN.
- Los datasets contiene precio de apertura, cierre, máximo y mínimo.

### **Objetivo**
- Entrenar una red recurrente que sea capaz de pronosticas correctamente los precios de cierre del índice S&P500.
---

## **Pasos necesarios para ejecutar el código**
**Paso 0, Paso 1: Importar librerías y descargar los datos**  
Se importaron las librerías necesarias para el análisis, necesarias para el entrenamiento de la red neuronal convolucional (CNN), el pre-procesamiento y procesamiento de imágenes, y la visualización de resultados. PyTorch se utilizó como una de las librerías principales, mientras que Torchvision igual se utilizó, puesto que facilita la gestión de los datos utilizados y la aplicación de transformaciones a las imágenes. Para obtener las imagenes que va a emplear el modelo, se utiliza la Kaggle API dentro del entorno de ejecución. El archivo descargado es finalmente descomprimido y guardado en una dirección local de la computadora.

**Paso 2: Definición de rutas**  
Se definieron las rutas de los conjuntos de entrenamiento y validación. Los datos descargados de Kaggle están organizados en dos carpetas que contienen imágenes clasificadas en conjuntos de entrenamiento y prueba. Estas imágenes se dividen en tres categorías según la severidad del daño del vehículo (menor, moderado y severo). Lo anterior permite la observación y análisis de cada clase de interés de manera estructurada y facilita la implementación de medidas de desempeño del modelo.

**Paso 3: Definir transformaciones que se van a emplear**  
Se definieron las transformaciones necesarias para preprocesar las imágenes antes de ser utilizadas en la red neuronal convolucional (CNN), ya que esta necesita que todos los inputs tengan un estandar para ello  se redimensionan todas las imágenes a un tamaño uniforme de 64x64 píxeles para garantizar la consistencia en la entrada del modelo y homogeneizar el tamaño de todas las imágenes en la base de datos. Hecho esto, las imágenes se convierten a tensores mediante **ToTensor()**, lo que permite representar los valores de los píxeles en un rango de 0 a 1 y facilitar su procesamiento por PyTorch. Finalmente, se aplica normalización con una media de 0.5 y una desviación estándar de 0.5 en cada canal de color (RGB), lo que ayuda a mejorar la estabilidad y eficiencia del entrenamiento al centrar los valores en torno a cero y reducir la variabilidad en la distribución de los datos.

**Paso 4: Cargamos las bases de datos que vamos a usar en el modelo**  
Se cargan los conjuntos de datos de entrenamiento y prueba que serán utilizados por el modelo. Las imágenes incluidas en estos conjuntos ya han sido preprocesadas mediante las transformaciones definidas en el paso anterior, lo que garantiza que todas tengan un formato uniforme y estén normalizadas. Cada conjunto de datos conserva la clasificación original en tres categorías según la severidad del daño del vehículo, lo que permite que el modelo aprenda a diferenciarlas de manera efectiva durante el entrenamiento y la evaluación.

*Clases encontradas: ['01-minor', '02-moderate', '03-severe']*
*Imagenes en base de datos de entrenamiento: 1383*
*Imagenes en base de datos de prueba: 248*

**Paso 5: Definimos el modelo CNN**  
Posteriormente, se plantea una red neuronal convolucional (CNN) en PyTorch. La red está diseñada para la clasificación en tres categorías y consta de tres capas convolucionales seguidas de Batch Normalization, activación Leaky ReLU y Max Pooling. Específicamente, Batch Normalization sirve para estabilizar la distribución de las activaciones en cada capa, reduciendo la dependencia del modelo en la inicialización de los pesos, lo cual acelera el entrenamiento del modelo. Las capas convolucionales utilizan filtros para extraer características importantes de la imagen, mientras que el Max Pooling reduce la dimensionalidad seleccionando el valor máximo en regiones pequeñas, conservando la información más relevante y reduciendo la cantidad de parámetros a procesar.

Para mejorar la capacidad de aprendizaje, se emplea la función de activación Leaky ReLU, que, a diferencia de la ReLU tradicional, permite el paso de valores negativos con una pendiente pequeña, evitando el problema de neuronas muertas. Tras las convoluciones y reducciones de tamaño, los datos se aplanan y pasan por capas densamente conectadas. La primera capa completamente conectada usa Dropout como regularización para prevenir el sobreajuste, dejando inactivas aleatoriamente algunas neuronas en cada iteración. Finalmente, la última capa de salida produce un vector de tres valores, que representan la probabilidad de pertenencia a cada una de las clases del modelo.

**Paso 6: Preparar optimizador / pérdida**  
Se define la función de pérdida y el optimizador para el entrenamiento del modelo. Se utiliza *CrossEntropyLoss*, una función que se puede utilizar para problemas de clasificación multiclase que mide la diferencia entre las predicciones del modelo y las etiquetas reales. Para la optimización de los parámetros, se emplea *Stochastic Gradient Descent* (SGD) con una tasa de aprendizaje de 0.01. Esto permite actualizar los pesos del modelo en función del error obtenido en cada iteración. 

**Paso 7: Entrenar el modelo**  

El modelo se entrenó durante 7 épocas, ajustando sus pesos en cada iteración para mejorar su precisión. En cada época, se establece el modo de entrenamiento y se inicializan las variables de pérdida y precisión acumuladas. Luego, para cada lote de imágenes en el conjunto de entrenamiento, se calcula la pérdida utilizando la función de entropía cruzada (*CrossEntropyLoss*), y mediante retropropagación (*loss.backward()*), se ajustan los pesos utilizando el optimizador SGD (*Stochastic Gradient Descent*).

A lo largo del entrenamiento, se lleva un seguimiento del número de predicciones correctas y la pérdida acumulada. Al finalizar cada época, se calcula la pérdida promedio y la precisión del modelo, proporcionando información sobre su rendimiento en la tarea de clasificación. Estos valores se imprimen al final de cada iteración, permitiendo evaluar la convergencia del modelo y su capacidad para generalizar los datos de entrada.


**Paso 8: Evaluar el modelo en el conjunto de validacion** 

Esta etapa, se evalúa el rendimiento del modelo en el conjunto de prueba. Primero, se cambia el modelo al modo de evaluación (*model.eval()*) para desactivar técnicas como Dropout y Batch Normalization, asegurando que las predicciones sean consistentes. Luego, se recorren los datos de prueba sin calcular gradientes (*torch.no_grad()*) para optimizar la memoria y el rendimiento. A cada imagen se le obtiene su predicción utilizando la clase con mayor probabilidad, y se almacenan tanto las etiquetas reales como las predichas para su posterior análisis.

Una vez recopiladas todas las predicciones, se calculan métricas clave como precisión (*accuracy*), precisión ponderada (*precision*), *recall* y *F1-score*, proporcionando una visión global del desempeño del modelo. Además, se genera un reporte detallado de clasificación con métricas por clase, permitiendo analizar su rendimiento en cada categoría. Para complementar la evaluación, se construye una matriz de confusión, que muestra la distribución de aciertos y errores entre las clases. Esta matriz se visualiza gráficamente con *seaborn*, facilitando la interpretación de los patrones de error y posibles áreas de mejora en la clasificación del modelo.


---

## **Explicación del modelo y resultados**

La evaluación del modelo muestra una precisión total de 58.47%, lo que indica que el modelo clasifica correctamente aproximadamente el 58.5% de las imágenes en el conjunto de prueba. Sin embargo, para entender mejor su rendimiento, es importante analizar las métricas por clase.

# Análisis por clase:

**Clase 0 (Severidad Menor)**

* **Precisión:** De todas las veces que el modelo predijo esta clase, acertó en el 64.08%.
* **Recall:** De todas las imágenes que realmente pertenecen a esta clase, el modelo identificó correctamente el 80.49%.
* **F1-score:**  Mide el balance entre precisión y recall y se obtuvo un valor de 71.35%, lo cual indica un desempeño aceptable de clasificación.

**Clase 1 (Severidad Moderada)**

* **Precisión:** El modelo comete bastantes errores al predecir esta clase y solo obtuvo una precisión de 42.59%.
* **Recall:** Solo detecta correctamente el 30.67% de las imágenes que realmente pertenecen a esta clase.
* **F1-score:** Indica un rendimiento deficiente en esta categoría, ya que el valor del f1_score es de 35.66%, lo cual parece indicar que el modelo confunde esta clase con otras.

**Clase 2 (Severidad Alta)**

* **Precisión:** La tasa de aciertos al predecir esta clase es aceptable con un 61.54%.
* **Recall:** Identifica correctamente el 61.54% de las imágenes de esta clase.
* **F1-score:** Tiene un valor de 61.54%, lo que muestra un rendimiento equilibrado en comparación con las otras clases.

**Conclusiones generales:**
El modelo clasifica bien la clase 0 (Severidad Menor), ya que tiene un alto recall (80.49%), lo que significa que detecta la mayoría de los casos de esta categoría de manera correcta.
La clase 1 (Severidad Moderada) presenta el peor rendimiento, con una recall de solo 30.67%, lo que sugiere que el modelo tiene dificultades para identificar correctamente estos casos y los está clasificando incorrectamente en otras categorías.
La clase 2 (Severidad Alta) tiene un rendimiento aceptable, con valores equilibrados entre precisión y recall.

**Posibles mejoras al modelo:**
* Se puede aumentar la cantidad de datos de la clase 1 (Severidad Moderada) si el dataset está desbalanceado, y podríamos emplear algunas técnicas para equilibrar las clases.
* Ajustar los hiperparámetros del modelo, como la tasa de aprendizaje o el número de capas.
* Aplicar transformaciones adicionales a las imágenes para poder detectar de mejor manera las características de las imágenes.
En general, el modelo logra un rendimiento aceptable en algunas clases, pero necesita ajustes para mejorar la clasificación de la clase 1, que es la más problemática

Para complementar el análisis, a continuación, se presenta la matriz de confusión.

**Matriz de Confusión**  

La matriz de confusión muestra el desempeño del modelo al clasificar imágenes en tres categorías: menor, moderado y severo. Se observa que la clase menor es la mejor clasificada, con 66 predicciones correctas y pocos errores en las demás clases. Sin embargo, la categoría moderado tiene una alta tasa de error, con solo 23 aciertos y muchas imágenes clasificadas erróneamente como menor (24) o severo (28), lo que explica su bajo recall en las métricas anteriores. Por otro lado, la clase de mayor severidad tiene un desempeño relativamente bueno, con 56 aciertos, pero con una cantidad considerable de imágenes mal clasificadas como moderada (22) o menor (13). Estos resultados sugieren que el modelo tiene dificultades para diferenciar la categoría Moderate, lo que podría mejorarse con técnicas como aumento de datos o ajuste de hiperparámetros. Es importante mencionar que se puede ver que existe una confusión bastante grande entre la clase moderada y la clase severa.

![matriz_conf](https://github.com/user-attachments/assets/54236e5f-92c2-467b-bd59-5b0bea1ace9a)

---
