module Payments
  class NotFriendsError < VenmoApiError
    def initialize(msg = I18n.t('errors.payments.not_friends'))
      super
    end
  end
end
