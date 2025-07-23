# ---- Setup inicial para el paquete sigPCA ----

# Instalar y cargar {usethis}, {devtools}, {roxygen2}, {testthat}, {S6} si hace falta
install.packages(c("usethis", "devtools", "roxygen2", "testthat", "S6"))

# ---- Crear el paquete ----
usethis::create_package("~/GITS/sigPCA")  # Cambia el path si es necesario

# ---- Ir a la carpeta del proyecto ----
usethis::proj_activate("~/GITS/sigPCA")

# ---- Usar control de versiones ----
usethis::use_git()

# ---- Licencia MIT ----
usethis::use_mit_license(name = "Guillermo de Anda Jáuregui")

# ---- Archivo README.Rmd básico ----
usethis::use_readme_rmd()

# ---- Añadir {testthat} ----
usethis::use_testthat()

# ---- Añadir dependencias ----
usethis::use_package("S6")
usethis::use_package("stats")  # por cov(), eigen()
usethis::use_package("ggplot2", type = "Suggests")
usethis::use_package("RMTstat", type = "Suggests")  # para curve opcional

# ---- Ignorar archivos en build ----
usethis::use_build_ignore("dev_script.R")

# ---- Inicializar roxygen ----
usethis::use_roxygen_md()

# ---- Preparar namespace ----
usethis::use_namespace()

# ---- Preparar estructura para tests ----
usethis::use_test("pca_utils")
