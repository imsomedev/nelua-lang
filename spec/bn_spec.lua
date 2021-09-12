local lester = require 'nelua.thirdparty.lester'
local describe, it = lester.describe, lester.it

local expect = require 'spec.tools.expect'
local bn = require 'nelua.utils.bn'

local n = bn.parse
local f = bn.from

describe("bn", function()

it("big numbers", function()
  expect.equal('0', n(0):todecint())
  expect.equal('0', n(-0):todecint())
  expect.equal('1', n(1):todecint())
  expect.equal('-1',n(-1):todecint())
  expect.equal('0.5', bn.todecsci(0.5))
  expect.equal('-0.5', bn.todecsci(-0.5))
  expect.equal('0.30000000000000004', bn.todecsci(.1+.2))
  expect.equal('1000', bn.todecsci(1000))
  expect.equal('0.14285714285714285', bn.todecsci(n(1)/ n(7)))
  expect.equal('1.4285714285714286', bn.todecsci(n(10)/ n(7)))
  expect.equal('-0.14285714285714285', bn.todecsci(n(-1)/ n(7)))
  expect.equal('-1.4285714285714286', bn.todecsci(n(-10)/ n(7)))
  expect.equal('14.285714285714286', bn.todecsci(n(100)/ n(7)))
  expect.equal('-14.285714285714286', bn.todecsci(n(-100)/ n(7)))
  expect.equal('0.014285714285714287', bn.todecsci(n('0.1')/ n(7)))
  expect.equal('-0.014285714285714287', bn.todecsci(n('-0.1')/ n(7)))
  expect.equal('0.0001', bn.todecsci(0.0001))
  expect.equal('1e-5', bn.todecsci('0.00001'))
  expect.equal('0.0001', bn.todecsci(0.0001))
  expect.equal('1.4285714285714285e-5', bn.todecsci(n(1) / n(70000)))
  expect.equal('1.4285714285714285e-5', bn.todecsci(1 / 70000))
  expect.equal(1, n(1):compress())
  expect.equal(0.5, bn.compress(0.5))
  expect.equal(f'0xffffffffffffffff', f'0xffffffffffffffff':compress())
end)

it("regular number conversion", function()
  expect.equal(n(0):tonumber(), 0)
  expect.equal(n(1):tonumber(), 1)
  expect.equal(n(-1):tonumber(), -1)
  expect.equal(n(123456789):tonumber(), 123456789)
end)

it("decimal number conversion", function()
  expect.not_fail(function() f'nan' f'inf' f'-inf' end)
  expect.equal(f'0', n(0))
  expect.equal(f'1', n(1))
  expect.equal(f'-1', n(-1))
  expect.equal(f'4096', n(4096))
  expect.equal(f'65536', n(65536))
  expect.equal(bn.todecsci('12345.6789'), '12345.6789')
  expect.equal(bn.todecsci('-12345.6789'), '-12345.6789')

  expect.equal('0', bn.todecsci(0))
  expect.equal('0', bn.todecsci(-0))
  expect.equal('1', bn.todecsci(1))
  expect.equal('-1',bn.todecsci(-1))
  expect.equal('0.5', bn.todecsci(0.5))
  expect.equal('-0.5', bn.todecsci(-0.5))
  expect.equal('0.30000000000000004', bn.todecsci(.1+.2))
  expect.equal('0.30000000000000004', bn.todecsci(n(.1)+n(.2)))
  expect.equal('0.30000000000000004', bn.todecsci(n('.1')+n('.2')))
  expect.equal('1000', bn.todecsci(1000))
end)

it("hexadecimal conversion", function()
  expect.equal(f'0x0', n(0))
  expect.equal(f'-0x0', n(0))
  expect.equal(f'0x1', n(1))
  expect.equal(f'-0x1', n(-1))
  expect.equal(f'0x1234567890', n(0x1234567890))
  expect.equal(f'0xabcdef', n(0xabcdef))
  expect.equal(f'0xffff', n(0xffff))
  expect.equal(f'-0xffff', n(-0xffff))
  expect.equal(f'0xffffffffffffffff', f'18446744073709551615')
  expect.equal(f'-0xffffffffffffffff', f'-18446744073709551615')

  expect.equal(f'0x1234567890abcdef':tohexint(), '1234567890abcdef')
  expect.equal(f'0x0':tohexint(), '0')
  expect.equal(f'0xffff':tohexint(), 'ffff')
  expect.equal(f'-0xffff':tohexint(64), 'ffffffffffff0001')
end)

it("binary conversion", function()
  expect.equal(f'0b0', n(0))
  expect.equal(f'0b1', n(1))
  expect.equal(f'0b10', n(2))
  expect.equal(f'0b11', n(3))
  expect.equal(f'-0b11', n(-3))
  expect.equal(f'0b11111111', n(255))
  expect.equal(f'0b100000000', n(256))


  expect.equal(f'0b11':tobinint(), '11')
  expect.equal(f'0b10':tobinint(), '10')
  expect.equal(f'0b1':tobinint(), '1')
  expect.equal(f'0b0':tobinint(), '0')
  expect.equal(f'-0x1':tobinint(8), '11111111')
end)

it("scientific notation", function()
  expect.equal('0.14285714285714285', bn.todecsci(n(1)/ n(7)))
  expect.equal('1.4285714285714286', bn.todecsci(n(10)/ n(7)))
  expect.equal('-0.14285714285714285', bn.todecsci(n(-1)/ n(7)))
  expect.equal('-1.4285714285714286', bn.todecsci(n(-10)/ n(7)))
  expect.equal('14.285714285714286', bn.todecsci(n(100)/ n(7)))
  expect.equal('-14.285714285714286', bn.todecsci(n(-100)/ n(7)))
  expect.equal('0.014285714285714287', bn.todecsci(0.1/ n(7)))
  expect.equal('-0.014285714285714287', bn.todecsci(-0.1/ n(7)))
  expect.equal('0.0001', bn.todecsci(0.0001))
  expect.equal('1e-5', bn.todecsci('0.00001'))
  expect.equal('0.0001', bn.todecsci(0.0001))
  expect.equal('1.4285714285714285e-5', bn.todecsci(n(1) / n(70000)))
  expect.equal('1.4285714285714285e-5', bn.todecsci(1 / 70000))
end)

end)
