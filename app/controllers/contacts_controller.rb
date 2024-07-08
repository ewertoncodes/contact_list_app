class ContactsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_contact, only: [ :show, :edit, :update, :destroy ]

  # GET /contacts
  def index
    @contacts = current_user.contacts
  end

  # GET /contacts/1
  def index
    @pagy, @contacts = pagy(ContactSearchQuery.new(current_user.contacts.order(name: :asc)).search(params[:search]), items: 10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @contacts }
    end
  end

  def show
  end

  # GET /contacts/new
  def new
    @contact = current_user.contacts.build
  end

  # GET /contacts/1/edit
  def edit
  end

  # POST /contacts
  def create
    @contact = current_user.contacts.build(contact_params)

    if @contact.save
      redirect_to @contact, notice: "Contact was successfully created."
    else
      render :new
    end
  end

  # PATCH/PUT /contacts/1
  def update
    if @contact.update(contact_params)
      redirect_to @contact, notice: "Contact was successfully updated"
    else
      render :edit
    end
  end

  # DELETE /contacts/1
  def destroy
    @contact.destroy
    redirect_to contacts_url, notice: "Contact was successfully destroyed."
  end

  private
    def set_contact
      @contact = current_user.contacts.find(params[:id])
    end

    def contact_params
      params.require(:contact).permit(:name, :cpf, :phone, :address, :postalcode, :latitude, :longitude)
    end
end
