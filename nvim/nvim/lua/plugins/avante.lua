return {
  {
    "yetone/avante.nvim",
    enabled = false,
    build = vim.fn.has("win32") ~= 0
      and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
      or "make",
    event = "VeryLazy",
    version = false,
    opts = {
      instructions_file = "avante.md",
      provider = "claude",
      providers = {
        claude = {
          endpoint = "https://api.anthropic.com",
          model = "claude-sonnet-4-6",
          api_key = os.getenv("ANTHROPIC_API_KEY"),
          extra_request_body = {
            max_tokens = 8192,
          },
        },
        gemini = {
          model = "gemini-2.0-flash",
          api_key = os.getenv("GEMINI_API_KEY"),
          extra_request_body = {
            max_tokens = 8192,
          },
        },
        copilot = {
          model = "claude-sonnet-4-5",
        },
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "folke/snacks.nvim",
      "nvim-tree/nvim-web-devicons",
      "zbirenbaum/copilot.lua",
      {
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = { insert_mode = true },
            use_absolute_path = true,
          },
        },
      },
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = { file_types = { "markdown", "Avante" } },
        ft = { "markdown", "Avante" },
      },
    },
  },
}
