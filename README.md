# RubyGen

This library doesn't understand Ruby code, but it handles indentation for you.

If you're looking for a code generator that takes s-expressions, check out Jim Weirich's [Sorcerer](https://github.com/jimweirich/sorcerer).

## Usage

### Initialize

```ruby
rubygen = RubyGen.new
```

### Use

```ruby
rubygen.indent 'if free?'
rubygen << 'take_it'
rubygen.blank
rubygen << 'drink'
rubygen.end
```

### Output

```ruby
puts rubygen.code
```

prints this:

```
if free?
  take_it

  drink
end
```
