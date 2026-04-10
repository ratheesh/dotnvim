return {
  {
    "Civitasv/cmake-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    ft = { "cmake", "c", "cpp" },
    keys = {
      { "<leader>mb", "<cmd>CMakeBuild<cr>",               desc = "CMake build" },
      { "<leader>mc", "<cmd>CMakeConfigure<cr>",           desc = "CMake configure" },
      { "<leader>mr", "<cmd>CMakeRun<cr>",                 desc = "CMake run" },
      { "<leader>mf", "<cmd>CMakeSelectBuildType<cr>",     desc = "CMake build type" },
      { "<leader>mt", "<cmd>CMakeSelectLaunchTarget<cr>",  desc = "CMake launch target" },
      { "<leader>mC", "<cmd>CMakeClean<cr>",               desc = "CMake clean" },
    },
    opts = {
      cmake_build_directory = "build/${variant:buildType}",
      cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON" },
    },
  },
}
