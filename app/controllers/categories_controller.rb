class CategoriesController < ApplicationController

  before_filter :authenticate
  before_filter :admin_user

  active_scaffold :category do |config|
    config.nested.add_scoped_link(:children)  #nested link to children
    config.list.columns.exclude   :position
    config.create.columns.exclude :position
    config.update.columns.exclude :position

    config.create.columns.exclude :products
    config.update.columns.exclude :products

    config.create.columns << :parent

      # from http://vhochstein.wordpress.com/2011/01/21/activescaffold-refresh-list-after-crud/
    config.create.refresh_list = true
    config.update.refresh_list = true

  end

  def edit
    super
  end


  protected

  # If nested let active_scaffold manage everything
  # if not just show all root nodes
  def beginning_of_chain
    nested? ? super : active_scaffold_config.model.roots
  end

  # Assign parent node to just created node
  def after_create_save(record)
    if (nested? && nested.scope)
      parent = nested_parent_record(:read)
      record.send("#{nested.scope}").send(:<<, parent) unless parent.nil?
    end
  end

  #def conditions_for_collection
  #  #['ORDER BY (?)', 'name']
  #  Category.order(:name)
  #end

  def before_create_save(record)
    set_parent_id_for_active_scaffold_record record, params
  end

  def after_create_save(record)
    #list and return
  end

  def after_update_save(record)
    #list and return
  end


  def set_parent_id_for_active_scaffold_record record, params
    if record and params and params['record']
      parent_id = params['record']['parent_id']
      if parent_id
        record.parent_id = parent_id
      end
    end
  end
end 
