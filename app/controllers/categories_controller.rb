class CategoriesController < ApplicationController

  before_filter :authenticate
  before_filter :admin_user

  active_scaffold :category do |config|
    config.nested.add_scoped_link(:children)  #nested link to children
    config.list.columns.exclude   :position
    config.create.columns.exclude :position
    config.update.columns.exclude :position
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
end 
