class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

         has_many :comments
         has_many :movies
         has_many :groups
         has_many :posts
         has_many :favorites
         has_many :group_relationships
         has_many :participated_movies, :through => :favorites, :source => :movie
         has_many :participated_groups, :through => :group_relationships, :source => :group

         def is_member_of?(group)
           participated_groups.include?(group)
         end

         def is_member?(movie)
           participated_movies.include?(movie)
         end


end
