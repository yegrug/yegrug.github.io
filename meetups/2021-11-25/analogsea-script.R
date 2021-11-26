## analogsea tutorial
## Model fitting in the cloud with Mauricio Vargas
## YEGRUG - November 25, 2021

library(analogsea)
library(tidyverse)
library(future)
library(furrr)
library(gapminder)
library(broom)
library(tictoc)

sizes <- sizes(per_page = 100)

sizes %>%
  filter(memory == max(memory))

s <- "c2-4vcpu-8gb"

# crear maquinas virtuales
# create virtual machines

droplet1 <- droplet_create("LatinR1", region = "sfo3", size = s, image = "rstudio-20-04")
# droplet2 <- droplet_create("LatinR2", region = "sfo3", size = s, image = "rstudio-20-04")

# puedo crear N maquinas virtuales con un loop
# I can create N machines by using a loop

# obtengo las IP
# get IPs

ip1 <- droplet_ip(droplet1)
# ip2 <- droplet_ip(droplet2)
# ips <- c(ip1, ip2)
ips <- ip1

# especificar llave SSH
# specify SSH key

ssh_private_key_file <- "~/.ssh/id_rsa"

# crear usuario
# create user

droplet1 <- droplet(droplet1$id)
pass <- create_password()
droplet1 %>%
  ubuntu_create_user("pacha", pass, keyfile = ssh_private_key_file)

# crear cluster
# create cluster

cl <- makeClusterPSOCK(
  ips,

  setup_strategy = "sequential",

  user = "root",

  # Usar la llave SSH privada que se registro en DO
  # Use private SSH key registered with DO

  rshopts = c(
    "-o", "StrictHostKeyChecking=no",
    "-o", "IdentitiesOnly=yes",
    "-i", ssh_private_key_file
  ),

  rscript = "Rscript",

  # Ejecutar estas cosas cada vez que se inicia la instancia remota
  # Asegurarse de que el computador remoto use todos los nucleos de la CPU

  # Things to run each time the remote instance starts
  # Make sure the remote computer uses all CPU cores

  rscript_args = c(
    "-e", shQuote("local({p <- Sys.getenv('R_LIBS_USER'); dir.create(p, recursive = TRUE, showWarnings = FALSE); .libPaths(p)})"),
    "-e", shQuote("options(mc.cores = parallel::detectCores())")
  ),

  dryrun = FALSE
)

# crear plan de trabajo
# create working plan

plan(cluster, workers = cl)

# particionar datos y subir a DO
# partition data and upload to DO

gapminder_to_model <- gapminder %>%
  group_by(continent) %>%
  nest()

gapminder_to_model

gapminder_to_model %>%
  filter(continent == "Asia") %>%
  unnest()

# enviar cada parte de los datos a cada 'nucleo'
# send each data fraction to each 'core'
modelo <- function(d) {
  eflm::eglm(lifeExp ~ gdpPercap + country, data = d)
}

# en la nube no esta instalado eflm, lo instalo
# in the cloud there's no eflm, I install it

install_r_package(droplet1, "eflm")

tic()
gapminder_models <- gapminder_to_model %>%
  mutate(model = data %>% future_map(~ modelo(.x)))
toc()

tic()
gapminder_models_2 <- gapminder_to_model %>%
  mutate(model = data %>% map(~ modelo(.x)))
toc()

# tic-toc esta sesgado por la velocidad de conexion a internet, etc
# funciona mejor con datos que toman mas tiempo para ajustar

# tic-toc is biased by the speed of the internet connection, etc
# works better with data that takes a longer time to fit

# veo el resultado calculado en la nube
# see the result computed in the cloud

gapminder_models

# ahora ordeno con broom
# now I tidy with broom

gapminder_nube <- gapminder_models %>%
  mutate(tidied = model %>% map(~ tidy(.x))) %>%
  unnest(tidied)

gapminder_nube %>%
  filter(continent == "Oceania")

# elimino la maquina virtual
# delete the virtual machine

droplet_delete(droplet1)
# droplet_delete(droplet2)
