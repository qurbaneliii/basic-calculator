# Simple Interest Calculator

A small, easy-to-use simple interest calculator. This README explains the formula, gives examples, and includes a minimal example implementation.

## Description

Simple interest is calculated using the formula:

I = P × R × T

- I = interest
- P = principal amount (initial sum of money)
- R = annual interest rate (as a decimal; e.g., 5% → 0.05)
- T = time the money is invested for, in years

Total amount after interest:
A = P + I

## Features

- Compute simple interest for a given principal, annual rate, and time.
- Show the interest and the final amount (principal + interest).
- Example implementations in common languages are provided.

## Examples

Example 1:
- Principal = $1,000
- Annual rate = 5% (0.05)
- Time = 3 years

I = 1000 × 0.05 × 3 = $150
A = 1000 + 150 = $1,150

Example 2:
- Principal = $2,500
- Annual rate = 3.2% (0.032)
- Time = 1.5 years

I = 2500 × 0.032 × 1.5 = $120
A = 2500 + 120 = $2,620

## Usage (CLI examples)

Python (save as simple_interest.py):
```python
def simple_interest(principal, rate_percent, years):
    rate = rate_percent / 100.0
    interest = principal * rate * years
    total = principal + interest
    return interest, total

if __name__ == "__main__":
    p = float(input("Principal: "))
    r = float(input("Annual rate (%): "))
    t = float(input("Time (years): "))
    i, a = simple_interest(p, r, t)
    print(f"Interest: {i:.2f}")
    print(f"Total amount: {a:.2f}")
```

Node.js (save as simpleInterest.js):
```js
function simpleInterest(principal, ratePercent, years) {
  const rate = ratePercent / 100;
  const interest = principal * rate * years;
  const total = principal + interest;
  return { interest, total };
}

const args = process.argv.slice(2);
const [p, r, t] = args.map(Number);
const res = simpleInterest(p, r, t);
console.log(`Interest: ${res.interest.toFixed(2)}`);
console.log(`Total amount: ${res.total.toFixed(2)}`);
```

Shell (quick calculation example):
```sh
# usage: ./si.sh principal rate_percent years
principal=$1
rate_percent=$2
years=$3
interest=$(echo "$principal * ($rate_percent / 100) * $years" | bc -l)
total=$(echo "$principal + $interest" | bc -l)
printf "Interest: %.2f\nTotal amount: %.2f\n" "$interest" "$total"
```

## Tests / Validation

- Verify with the examples above.
- Edge cases: zero principal, zero rate, or zero years should return zero interest.

## License

MIT License — feel free to use and modify.

## How to publish this README to GitHub

1. Create a new public repository on GitHub (e.g., `simple-interest-calculator`).
2. Add this README.md to the repository root.
3. Commit and push.
4. The public URL will be: `https://github.com/<owner>/<repo>/blob/main/README.md` (replace `main` with your default branch if different).

If you want, I can create the repository and push this README for you — tell me the repository owner and name (and whether I should use `main` or `master` as the default branch).
