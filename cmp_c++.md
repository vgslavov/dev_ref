# C++ Standards Comparison: C++11 → C++20

| Feature Area | C++11 | C++14 | C++17 | C++20 |
|---|---|---|---|---|
| **Type deduction** | `auto`, `decltype`, trailing return types `auto f() -> int` | Generic lambdas `[](auto x){}`, return type deduction `auto f()` | Structured bindings `auto [a,b] = pair;`, CTAD `vector v{1,2,3}` | Concepts `template<std::integral T>`, abbreviated function templates `void f(auto x)` |
| **Templates** | Variadic templates `template<typename... Args>`, `static_assert` | Variable templates `template<class T> constexpr T pi = ...` | `if constexpr`, fold expressions `(args + ...)` | Concepts replace SFINAE, `consteval`, non-type template params accept floats/strings |
| **Compile-time** | `constexpr` (single return statement only), `static_assert` | Relaxed `constexpr` (loops, local vars) | `constexpr if`, `inline` variables | `constexpr` vector/string/dynamic alloc, `consteval`, `constinit` |
| **Lambdas** | Lambdas introduced `[&](int x){ return x; }` | Generic lambdas, generalized captures `[x = std::move(y)]` | Constexpr lambdas, capture `*this` by value | Template lambdas `[]<typename T>(T x){}`, lambdas in unevaluated contexts |
| **Move semantics / memory** | Move semantics, rvalue refs `&&`, `std::move`, `std::forward`, `std::unique_ptr`, `std::shared_ptr` | `std::make_unique` | — | `std::span` (non-owning view) |
| **String/formatting** | Raw string literals `R"(...)"`, `std::to_string` | `""s` string literal | `std::string_view` | `std::format("{} = {}", k, v)` |
| **Containers/types** | `std::array`, `std::tuple`, `std::unordered_map/set`, `std::chrono` | `std::integer_sequence` | `std::optional`, `std::variant`, `std::any`, `std::string_view` | `std::span`, calendar/timezone chrono, `std::source_location` |
| **Algorithms/ranges** | `std::begin/end`, `std::all_of/any_of/none_of` | Minor additions | `std::clamp`, parallel STL (`std::execution::par`) | Ranges library + views with pipe `\|` composition, projections |
| **Concurrency** | `std::thread`, `std::mutex`, `std::condition_variable`, `std::future/promise`, `std::atomic` | `std::shared_mutex` (timed) | `std::shared_mutex`, `std::scoped_lock` | `std::jthread`, `stop_token`, coroutines (`co_await`), `std::latch`, `std::barrier`, `std::counting_semaphore` |
| **Initialization** | Uniform init `{}`, initializer lists, in-class member init | — | Aggregate init extensions | Designated initializers `{.x=1, .y=2}` |
| **Enums/classes** | `enum class` (scoped enums), `override`/`final`, delegating constructors, `= delete`/`= default` | — | — | `using enum`, spaceship `<=>` auto-generates all 6 comparison operators |
| **Filesystem/IO** | — | — | `<filesystem>` library | — |
| **Modules/includes** | — | — | — | `import std;` replaces headers |
| **Attributes** | — | `[[deprecated]]` | `[[nodiscard]]`, `[[maybe_unused]]`, `[[fallthrough]]` | `[[nodiscard("reason")]]`, `[[likely]]`/`[[unlikely]]` |
| **Other highlights** | Range-based for, `nullptr`, type aliases `using`, `noexcept`, user-defined literals | Binary literals `0b1010`, digit separators `1'000'000` | Nested namespaces `A::B::C`, `std::byte` | Modules, three-way comparison |

## The Evolution in a Nutshell

**C++11** — The rebirth. Move semantics, lambdas, `auto`, smart pointers, threads, and uniform initialization made C++ a modern language. Nearly everything after builds on this foundation.

**C++14** — Polish on C++11. Generic lambdas and relaxed `constexpr` are the standouts.

**C++17** — The "practical utilities" release. `optional`, `variant`, `string_view`, structured bindings, `if constexpr`, `<filesystem>`, and parallel algorithms.

**C++20** — The biggest leap since C++11. Concepts, ranges, coroutines, modules, and `std::format` fundamentally change how modern C++ is written.