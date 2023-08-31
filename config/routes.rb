Rails.application.routes.draw do
  mount Comee::Core::Engine => "/comee_core", as: 'comee_core'
end
