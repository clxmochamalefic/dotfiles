
return {
  {
    'hat0uma/csvview.nvim',
    lazy = true,
    cmd = {
      'CsvViewEnable',
      'CsvViewDisable',
      'CsvViewToggle',
    },
    opts = {
      parser = {
        async_chunksize = 50,
        delimiter = {
          default = ",",
          ft = {
            tsv = "\t",
          },
        },
        quote_char = '"',
        comments = {
          -- "#",
          -- "--",
          -- "//",
        },
      },
      view = {
        min_column_width = 5,
        spacing = 2,
        display_mode = "border",
      },
    },
    config = function(_, opts)
      require('csvview').setup(opts)
    end,
  },
}
