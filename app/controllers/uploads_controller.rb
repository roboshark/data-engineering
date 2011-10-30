class UploadsController < ApplicationController

  # Acts Cruddy is a Gem that I wrote, available on GitHub:  https://github.com/topsail/acts_cruddy  - Mark Roghelia
  acts_cruddy :only => [ :index, :new, :create, :show, :destroy ], :formats => [ :html, :json ]

  prepend_before_filter :redirect_to_form, :only => :index

  private

  def redirect_to_form
    # Go straight to the form for the first upload.
    redirect_to new_upload_url if Upload.count == 0
  end

end
