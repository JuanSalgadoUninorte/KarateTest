# Comandos para ejecutar las pruebas -- KARATE FRAMEWORK
#### Por: Juan Salgado
## Ejecuciones
### Ejecución completa de todos los ".feature" y Scenarios que estos contienen
```bash
mvn test
```
#### Esta es una ejecución específica
```bash
mvn test -Dkarate.options="-t=@JustThisTest"
```
### Omisiones
Saltar un escenario, el "~" significa que debe omitir el escenario señalado.
```bash
mvn test "-Dkarate.options=--tags ~@skipme"
```
### Ejecición de una Scenario, detallando la línea de código en la cual se encuentra

```bash
mvn test -Dkarate.options="classpath:conduitApp/feature/articles.feature:19"
```
```bash
mvn test -X -Dkarate.options="classpath:conduitApp/feature/articles.feature:11"
```