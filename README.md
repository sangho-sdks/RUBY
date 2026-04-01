# Sangho Ruby SDK

Official Ruby SDK for the [Sangho](https://sangho.com) payment platform.

## Installation

```ruby
# Gemfile
gem "sangho"
```

```bash
bundle install
# or
gem install sangho
```

## Quick Start

```ruby
require "sangho"

sangho = Sangho.new("sk_test_xxx")

# Create a customer
customer = sangho.customers.create(email: "jean@example.com", name: "Jean Ondo")

# Create a payment intent
intent = sangho.payment_intents.create(amount: 25_000, customer: customer[:id])

# Confirm
confirmed = sangho.payment_intents.confirm(intent[:id])
```

## Configuration block

```ruby
Sangho.configure do |c|
  c.api_key  = "sk_test_xxx"
  c.base_url = "https://api.sangho.com/v1"
  c.timeout  = 30
end

client = Sangho::SanghoClient.new
```

## Webhook Verification

```ruby
event = Sangho::Resources::Webhooks.construct_event(
  request.body.read,
  request.headers["Sangho-Signature"],
  "whsec_xxx"
)
```

## Requirements

- Ruby 3.1+
- Faraday 2.x
