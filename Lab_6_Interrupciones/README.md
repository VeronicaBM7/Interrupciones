**Funcionamiento del sistema**
Las interrupciones que se están empleando en este sistema son de tipo externo por hardware. Se emplearon dos tipos de interrupciones para este sistema, uno que afecte el modo de conteo (ascendete o descendente) y otro que afecte la velocidad del conteo. 

	La siguiente lista muestra a grandes rasgos el funcionamiento del sistema

    1. Inicio

	2. Configuración de periféricos (Systic es una configuración de periféricos)

	3. Inicialización

	4. Delay = check_speed()

	5. If modo=0

	    Counter ++

	6. Else 

	    Counter --

	7. Output (counter)

	8. Wait(delay) Go to 4



check_speed:

Como su nombre lo dice se encarga de modificar la velocidad del conteo, por medio del  registro r8 se obtiene el valor de la interrupción ingresada por PA10. Conforme al valor del registro r8 será la velocidad. 

delay:

Esta función dependerá de la función check_speed. check_speed se encargará de comunicarle a delay el tiempo (speed).

systick_initialize:

Establece la Systick  para generar interrupciones en un intervalo de tiempo fijo.

systick_handler:

Decrementa la variable dada por check_speed.

reset_handler:

Es en el encargado de invocar a la función main.

EXTI15_10_Handler:

El sistema trabaja con interrupciones externas a través de los pines GPIO A10 y A11. En esta función se evalua el valor de los pines A10 y A11, según sea el valor de la comparación, será la interrupción solicitada. 

**Configuración de los perifericos**
Utilice el puerto A:
Outputs: A0 - A9  
Inputs: A10 y A11

**Manera de compilar el software**

make cleanwin: sirve para limpiar el proyecto.

make : sirve para ensamblar y enlazar.

make write: sirve para grabar.


**Diagrama de cómo conectar el hardware**