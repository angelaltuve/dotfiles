return {
  default = {
    use_absolute_path = false,
    relative_to_current_file = false,
    dir_path = "assets",
    prompt_for_file_name = false,
    file_name = "%y%m%d-%H%M%S",
    extension = "avif",
    process_cmd = "convert - -quality 75 avif:-",
  },

  filetypes = {
    markdown = {
      url_encode_path = true,
      template = "![Image](./$FILE_PATH)",
    },
    typst = {
      url_encode_path = true,
      relative_to_current_file = false,
      dir_path = "assets",
      extension = "webp",
      process_cmd = "convert - -quality 75 webp:-",
      template = [[
#figure(
  image("$FILE_PATH"),
  caption: [$CURSOR],
) <fig-$LABEL>
    ]],
    },
  },
}
