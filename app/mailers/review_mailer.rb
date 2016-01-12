class ReviewMailer < ApplicationMailer
  def new_review(review)
    @review = review

     mail(
       to: review.pokemon.user.email,
       subject: "New Review for your #{review.pokemon.name}"
     )
  end
end
