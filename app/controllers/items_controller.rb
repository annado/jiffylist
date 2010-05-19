class ItemsController < ApplicationController
  # GET /list/123/items/new
  # GET /list/123/items/new.xml
  def new
    @item = Item.new

    respond_to do |format|
      format.html { render :action => ""}
      format.xml  { render :xml => @item }
    end
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
  end

  # POST /list/123/items
  # POST /list/123/items.xml
  def create
    @list = List.find_by_hash_id(params[:hash_id])
    @items = @list.items

    if params[:item]
      params[:item][:list] = @list
      params[:item][:checked] = false
      @item = Item.new(params[:item])
      if @item.save
        flash[:notice] = 'Item was successfully created.'
      end
    else
      @item = @list.items.new(:list => @list)
    end

    respond_to do |format|
      if @item.save
        flash[:notice] = 'Item was successfully created.'
        format.html { redirect_to('/list/' + params[:hash_id]) }
        format.xml  { render :xml => @item, :status => :created, :location => @item }
        format.json  { render :json => @item, :status => :created }
      else
        format.html { redirect_to('/list/' + params[:hash_id]) }
        format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
        format.json  { render :json => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /items/1
  # PUT /items/1.xml
  def check
    @item = Item.find(params[:id])

    respond_to do |format|
      if @item.update_attributes('checked' => !@item.checked)
        flash[:notice] = 'Item was successfully updated.'
        format.html { redirect_to('/list/' + @item.list.hash_id) }
        format.xml  { head :ok }
        format.xml  { head :ok, :json => @item }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /items/1
  # PUT /items/1.xml
  def update
    @item = Item.find(params[:id])

    respond_to do |format|
      if @item.update_attributes(params[:item])
        flash[:notice] = 'Item was successfully updated.'
        format.html { redirect_to('/list/' + @item.list.hash_id) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.xml
  def destroy
    @item = Item.find(params[:id])
    hash_id = @item.list.hash_id
    @item.destroy

    respond_to do |format|
      format.html { redirect_to('/list/' + hash_id) }
      format.xml  { head :ok }
    end
  end
end
