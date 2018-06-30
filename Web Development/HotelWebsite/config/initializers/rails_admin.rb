RailsAdmin.config do |config|

  config.authorize_with do
    redirect_to main_app.root_path unless current_user.is_admin?
  end

  config.model User do
    list do
      field :email
      field :phone
      field :name
      field :is_admin
    end

    show do
      field :email
      field :phone
      field :name
      field :is_admin
    end
  end

  config.model Reservation do
    list do
      fields :apartment_type, :payment_type do
        formatted_value do
          value.humanize
        end
      end
      field :arrival_date
      field :departure_date
      field :user
      field :user_phone do
        formatted_value do
          "#{bindings[:object].user.phone}"
        end
      end
    end
  end

  config.model Review do
    list do
      field :text
      field :rating
      field :user
      field :created_at
    end
  end

  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    bulk_delete
    show
    edit
    delete

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
