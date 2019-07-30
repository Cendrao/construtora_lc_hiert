defmodule ConstrutoraLcHiertWeb do
  @moduledoc """
  The entrypoint for defining your web interface, such
  as controllers, views, channels and so on.

  This can be used in your application as:

      use ConstrutoraLcHiertWeb, :controller
      use ConstrutoraLcHiertWeb, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below. Instead, define any helper function in modules
  and import those modules here.
  """

  def controller do
    quote do
      use Phoenix.Controller, namespace: ConstrutoraLcHiertWeb

      import ConstrutoraLcHiertWeb.Gettext
      import Phoenix.LiveView.Controller, only: [live_render: 3]
      import Plug.Conn

      alias ConstrutoraLcHiertWeb.Router.Helpers, as: Routes
    end
  end

  def view do
    quote do
      use Phoenix.View,
        root: "lib/construtora_lc_hiert_web/templates",
        namespace: ConstrutoraLcHiertWeb

      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      # Import convenience functions from controllers
      import ConstrutoraLcHiertWeb.ErrorHelpers
      import ConstrutoraLcHiertWeb.Gettext
      import ConstrutoraLcHiertWeb.Helpers.CheckboxHelper
      import ConstrutoraLcHiertWeb.Helpers.IconHelper
      import ConstrutoraLcHiertWeb.Helpers.CurrencyHelper
      import ConstrutoraLcHiertWeb.Helpers.ImageHelper

      import Phoenix.Controller,
        only: [get_flash: 1, get_flash: 2, view_module: 1, action_name: 1]

      import Phoenix.LiveView, only: [live_render: 2, live_render: 3, live_link: 1, live_link: 2]

      alias ConstrutoraLcHiertWeb.Router.Helpers, as: Routes
    end
  end

  def router do
    quote do
      use Phoenix.Router

      import Phoenix.Controller
      import Phoenix.LiveView.Router
      import Plug.Conn
    end
  end

  def channel do
    quote do
      use Phoenix.Channel

      import ConstrutoraLcHiertWeb.Gettext
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
