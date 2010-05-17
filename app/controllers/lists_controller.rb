class ListsController < ApplicationController
  # GET /lists
  # GET /lists.xml
  def index
    @list = List.new(:name => "My new list")

    recent = get_recent_lists
    if !recent.nil?
      @lists = List.find_all_by_hash_id(recent)
    #else 
    #  @lists = List.all
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @lists }
    end
  end

  # GET /lists/1
  # GET /lists/1.xml
  def show
    @list = List.find_by_hash_id(params[:hash_id])
    @items = @list.items
    @item = @list.items.new(:list => @list)
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @list }
    end
  end

  # GET /lists/new
  # GET /lists/new.xml
  def new
    @list = List.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @list }
    end
  end

  # GET /lists/1/edit
  def edit
    @list = List.find(params[:id])
  end

  # POST /lists
  # POST /lists.xml
  def create
    params[:list][:hash_id] = Time.now.hash.abs.to_s(36)
    @list = List.new(params[:list])

    add_recent_list @list.hash_id
    
    respond_to do |format|
      if @list.save
        flash[:notice] = 'List was successfully created.'
        format.html { redirect_to('/list/' + @list.hash_id) }
        format.xml  { render :xml => @list, :location => @list }
      else
        format.html { render :action => "index" }
        format.xml  { render :xml => @list.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /lists/1
  # PUT /lists/1.xml
  def update
    @list = List.find(params[:id])

    respond_to do |format|
      if @list.update_attributes(params[:list])
        flash[:notice] = 'List was successfully updated.'
        format.html { redirect_to(@list) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @list.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /lists/1
  # DELETE /lists/1.xml
  def destroy
    @list = List.find(params[:id])
    @list.destroy

    respond_to do |format|
      format.html { redirect_to(lists_url) }
      format.xml  { head :ok }
    end
  end
  
  def get_recent_lists 
    if !cookies[:recent].nil?
      cookies[:recent].split(',')
    end
  end
  
  def add_recent_list (hash_id)
    recent = cookies[:recent]
    if recent.nil?
      recent = hash_id
    else
      recent = recent.split(',')
      recent << hash_id
      recent = recent.join(',')
    end
    
    cookies[:recent] = recent
  end
end
