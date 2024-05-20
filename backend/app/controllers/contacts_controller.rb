# frozen_string_literal: true

require 'socket'

class ContactsController < ApplicationController
  before_action :set_contact, only: %i[show update destroy]

  # GET /contacts
  def index
    @contacts = Contact.all

    render json: @contacts
  end

  # GET /contacts/search
  def search
    if params[:shortname]
      @contacts = Contact.where('LOWER(shortname) LIKE ?', "%#{params[:shortname].downcase}%")
      render json: @contacts
    else
      render json: { 'error' => 'Query parameter `shortname` missing.' }
    end
  end

  # GET /contacts/1
  def show
    render json: @contact
  end

  # POST /contacts
  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      render json: @contact, status: :created, location: @contact
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /contacts/1
  def update
    if @contact.update(contact_params)
      render json: @contact
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  # DELETE /contacts/1
  def destroy
    @contact.destroy!
  end

  def status
    render json: { 'hostname' => Socket.ip_address_list.map(&:ip_address).join('; '),
                   'message' => 'Succesfully connected to the backend.', 'contacts' => Contact.all }
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_contact
    @contact = Contact.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def contact_params
    params.require(:contact).permit(:shortname, :fullname, :email)
  end
end
