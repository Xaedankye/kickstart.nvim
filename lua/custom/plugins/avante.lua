return {
  'yetone/avante.nvim',
  build = function()
    if vim.fn.has 'win32' == 1 then
      return 'powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false'
    else
      return 'make'
    end
  end,
  event = 'VeryLazy',
  version = false,
  ---@module 'avante'
  ---@type avante.Config
  opts = {
    provider = 'ollama',
    providers = {
      openai = {
        endpoint = 'https://api.openai.com/v1',
        model = 'gpt-4o',
        timeout = 30000,
        extra_request_body = {
          temperature = 0.75,
          max_tokens = 2048,
        },
      },
      gemini = {
        endpoint = 'https://generativelanguage.googleapis.com/v1beta/models',
        model = 'gemini-1.5-flash', -- <<<<<< CHANGE THIS BACK TO THIS
        timeout = 30000, -- Timeout in milliseconds
        extra_request_body = {
          temperature = 0.75,
          max_tokens = 20480,
        },
        allow_insecure = false,
      },
      ollama = {
        endpoint = 'http://localhost:11434', -- Ollama's default local API endpoint
        model = 'deepseek-coder-v2:16b', -- Use the exact model name you pulled with Ollama
        timeout = 60000, -- Local models might need a longer timeout
        extra_request_body = {
          temperature = 0.75,
          -- max_tokens is less critical for local models unless you want to constrain output
        },
        -- No API key needed for local Ollama
      },
    },
    rag_service = { -- RAG Service configuration
      enabled = false, -- Enables the RAG service
      host_mount = os.getenv 'HOME', -- Host mount path for the rag service (Docker will mount this path)
      runner = 'docker', -- Runner for the RAG service (can use docker or nix)
      llm = { -- Language Model (LLM) configuration for RAG service
        provider = 'openai', -- LLM provider
        endpoint = 'https://api.openai.com/v1', -- LLM API endpoint
        api_key = 'OPENAI_API_KEY', -- Environment variable name for the LLM API key
        model = 'gpt-4o-mini', -- LLM model name
        extra = nil, -- Additional configuration options for LLM
      },
      embed = { -- Embedding model configuration for RAG service
        provider = 'openai', -- Embedding provider
        endpoint = 'https://api.openai.com/v1', -- Embedding API endpoint
        api_key = 'OPENAI_API_KEY', -- Environment variable name for the embedding API key
        model = 'text-embedding-3-large', -- Embedding model name
        extra = nil, -- Additional configuration options for the embedding model
      },
      docker_extra_args = '', -- Extra arguments to pass to the docker command
    },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    'echasnovski/mini.pick',
    'nvim-telescope/telescope.nvim',
    'hrsh7th/nvim-cmp',
    'ibhagwan/fzf-lua',
    'stevearc/dressing.nvim',
    'folke/snacks.nvim',
    'nvim-tree/nvim-web-devicons',
    'zbirenbaum/copilot.lua',
    {
      'HakonHarnes/img-clip.nvim',
      event = 'VeryLazy',
      opts = {
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          use_absolute_path = true,
        },
      },
    },
    {
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { 'markdown', 'Avante' },
      },
      ft = { 'markdown', 'Avante' },
    },
  },
}
