class UploadsController < ApplicationController

  # Acts Cruddy is a Gem that I wrote, available on GitHub:  https://github.com/topsail/acts_cruddy
  # - Mark Roghelia
  acts_cruddy :only => [ :index, :new, :create, :show, :destroy ], :formats => [ :html, :json ]

end
