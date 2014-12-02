// lamda expressions
transform(l.begin(), l.end(), t.begin(), [](int i){ return i * i;});

// type inference (auto)
// range-based loops
// list initializers
vector<int> x = {1,2,3,4};
for(auto i : x)
    cout<< i <<endl;

// no hassle initialization of most? containers
const map<string,int> m = {{"Joe",2},{"Jack",3}};

// moving w/o copying
// (no change in code, just new compiler)
vector<vector<int> > V;
for(int k = 0; k < 100000; ++k) {
    vector<int> x(1000);
    V.push_back(x);
}


// constexpr
constexpr int gcd(int x, int y) {
    return (x % y) == 0 ? y :  gcd(y,x % y);
}
// gcd() will never get called at run-time (all at compile-time)
for(int k = 0; k < 100000; ++k) {
    vector<int> x(gcd(1000,100000));
    V.push_back(x);
}
