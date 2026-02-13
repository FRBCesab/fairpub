#'
#' Create an Hexagonal Sticker for the Package
#'

# install.packages(c("png", "ggplot2", "hexSticker", "grid", "ggpubr"))

rlogo <- png::readPNG(here::here("inst", "package-sticker", "r_logo.png"))
rlogo <- grid::rasterGrob(rlogo, interpolate = TRUE)


fp_image <- png::readPNG("inst/package-sticker/fairpub_1.png")
fp_image <- grid::rasterGrob(fp_image, interpolate = TRUE)


p <- ggplot2::ggplot() +
  ggplot2::annotation_custom(
    fp_image,
    xmin = -Inf,
    xmax = Inf,
    ymin = -Inf,
    ymax = Inf
  ) +
  ggplot2::theme_void() +
  ggpubr::theme_transparent()


hexSticker::sticker(
  subplot = p,
  package = "fairpub",
  filename = here::here("man", "figures", "package-sticker.png"),
  dpi = 600,

  p_size = 32.0, # Title
  u_size = 5.0, # URL
  p_family = "Aller_Rg",

  p_color = "#6e06f5ff", # Title
  h_fill = "#fdb6b6ff", # Background
  h_color = "#6e06f5ff", # Border
  u_color = "#6e06f5ff", # URL

  p_x = 1.00, # Title
  p_y = 0.60, # Title
  s_x = 1.00, # Subplot
  s_y = 1.25, # Subplot

  s_width = 1, # Subplot
  s_height = 1, # Subplot

  url = "https://github.com/frbcesab/fairpub",

  spotlight = TRUE,
  l_alpha = 0.10,
  l_width = 4,
  l_height = 4
)
