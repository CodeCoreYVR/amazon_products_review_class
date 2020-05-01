# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
      user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities

    can :manage, Product do |product|
      product.user == user 
    end 

    can :manage, Review do |review|
      review.user == user 
    end 

    can :like, Review do |review| 
      review.user != user 
    end 

    can :destroy, Like do |like| 
      like.user == user 
    end 

    # Because the product owner is the only one who 'can?' :manage the product, 
    # we can just use that cancan ability to authorize the hiding of the review
    # for the stretch exercise. 
    # We could also define a custom ability here in our ability.rb file strictly
    # for hiding the review. Something like: 
    # can :toggle_hidden, Review do |review|
    #   review.product.user == user 
    # end 
    # but in that case we wouldn't be able to use can :manage, Review... since 
    # :manage will appy to every action thus also allowing review owners to hid/shoe
    # their reviews

  end
end
