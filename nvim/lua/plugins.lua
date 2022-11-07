local M = {}

function M.setup()
  -- Indicate first time installation
  local packer_bootstrap = false 

  -- packer.nvim configuration
  local conf = {
    display = {
      open_fn = function()
        return require("packer.util").float { border = "rounded" }
      end,
    },
  }

  -- Check if packer.nvim is installed
  -- Run PackerCompile if there are changes in this file
  local function packer_init()
    local fn = vim.fn
    local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
      packer_bootstrap = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
      }
      vim.cmd [[packadd packer.nvim]]
    end
    vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"
  end

  -- Plugins
  local function plugins(use)
    use { "wbthomason/packer.nvim" }

    -- Colorscheme
    use {
      "shaunsingh/nord.nvim",
      config = function()
				require('config.theme.nord').setup()
      end,
    }

		-- WhichKey
		use {
			 "folke/which-key.nvim",
			 config = function()
				 require("config.whichkey").setup()
			 end,
		}
		
		-- status line
		use {
			"nvim-lualine/lualine.nvim",
			event = "VimEnter",
			config = function()
				require("config.lualine").setup()
			end,
			requires = { 'kyazdani42/nvim-web-devicons', opt = true }
		}

		use {
			"b0o/incline.nvim",
			config = function()
				require("config.incline").setup()
			end
		}

		use {
			"SmiteshP/nvim-gps",
			requires = "nvim-treesitter/nvim-treesitter",
			module = "nvim-gps",
			config = function()
				require("nvim-gps").setup()
			end,
		}

		use {
			"nvim-treesitter/nvim-treesitter",
			 run = ":TSUpdate",
			 config = function()
				 require("config.treesitter").setup()
			 end,
		}

		use {
			 "kyazdani42/nvim-tree.lua",
			 requires = {
				 "kyazdani42/nvim-web-devicons",
			 },
			 cmd = { "NvimTreeToggle", "NvimTreeClose" },
			 config = function()
				 require("config.nvimtree").setup()
			 end,
		}

		use {
			'numToStr/Comment.nvim',
			config = function()
				require('Comment').setup()
			end
		}

		-- Telescope
		use {
			"nvim-telescope/telescope.nvim",
			opt = true,
			config = function()
				require("config.telescope").setup()
			end,
			cmd = { "Telescope" },
			module = "telescope",
			keys = { "<leader>f", "<leader>p" },
			wants = {
				"plenary.nvim",
				"popup.nvim",
				"telescope-fzf-native.nvim",
				"telescope-project.nvim",
				"telescope-repo.nvim",
				"telescope-file-browser.nvim",
				"project.nvim",
			},
			requires = {
				"nvim-lua/popup.nvim",
				"nvim-lua/plenary.nvim",
				{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
				"nvim-telescope/telescope-project.nvim",
				"cljoly/telescope-repo.nvim",
				"nvim-telescope/telescope-file-browser.nvim",
				{
					"ahmedkhalf/project.nvim",
					config = function()
						require("project_nvim").setup {}
					end,
				},
			},
		}
 
		-- LSP stuff
		-- use({
		-- 	"jose-elias-alvarez/null-ls.nvim",
		-- 	requires = { "nvim-lua/plenary.nvim" },
		-- })

		use {
			"neovim/nvim-lspconfig",
			opt = true,
			event = "BufEnter",
			wants = { "cmp-nvim-lsp", "nvim-lsp-installer", "lua-dev.nvim", "null-ls.nvim" },
			-- wants = { "cmp-nvim-lsp", "nvim-lsp-installer", "lsp_signature.nvim" },
			config = function()
				require("config.lsp").setup()
			end,
			requires = {
				"williamboman/nvim-lsp-installer",
				-- "ray-x/lsp_signature.nvim",
				"folke/lua-dev.nvim",
				"jose-elias-alvarez/null-ls.nvim",
				{
					"j-hui/fidget.nvim",
					config = function()
						require("fidget").setup {}
					end,
				},
			},
		}

		use {
			"hrsh7th/nvim-cmp",
			event = "InsertEnter",
			opt = true,
			config = function()
				require("config.cmp").setup()
			end,
			wants = { "LuaSnip" },
			requires = {
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-nvim-lua",
				"ray-x/cmp-treesitter",
				"hrsh7th/cmp-cmdline",
				"saadparwaiz1/cmp_luasnip",
				"hrsh7th/cmp-calc",
				"f3fora/cmp-spell",
				"hrsh7th/cmp-emoji",
				"hrsh7th/cmp-nvim-lsp",
				{
					"L3MON4D3/LuaSnip",
					wants = "friendly-snippets",
					config = function()
						require("config.luasnip").setup()
					end,
				},
				"rafamadriz/friendly-snippets",
				disable = false,
			},
		}

		if packer_bootstrap then
			print "Restart Neovim required after installation!"
			require("packer").sync()
		end
	end

  packer_init()

  local packer = require "packer"
  packer.init(conf)
  packer.startup(plugins)
end

return M

