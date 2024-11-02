// ascending loop
for (size_t i = 0; i != len; ++i) {}

// descending loop
for (size_t i = len; i != 0; ) { --i; }

// erase an item from a list
for (auto i = list.begin(); i != list.end;)
{
    if (cond)
        i = list.erase(i);
    else
        ++i;
}
