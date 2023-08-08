Person.destroy_all
Family.destroy_all
f = Family.create(name: "Banasiewicz");
f.people.create(first_name: "Carolina", last_name: "Banasiewicz", dob: Date.new(1970, 8, 22));
f.people.create(first_name: "Monroe", last_name: "Banasiewicz", dob: Date.new(2007, 1, 5));
f.people.create(first_name: "Flynn", last_name: "Banasiewicz", dob: Date.new(2009, 10, 15));
f = Family.create(name: "Marudas");
f.people.create(first_name: "Colette", last_name: "Marudas", dob: Date.new(2005, 2, 21));
f.people.create(first_name: "Gunnar", last_name: "Marudas", dob: Date.new(2007, 1, 6));
f.people.create(first_name: "Palmer", last_name: "Marudas", dob: Date.new(2009, 5, 8));
f.people.create(first_name: "Moses", last_name: "Marudas", dob: Date.new(2012, 7, 11));
f = Family.create(name: "Tahhan");
f.people.create(first_name: "Dennis", last_name: "Tahhan", dob: Date.new(1985, 10, 12));
f = Family.create(name: "Protich/Vozenilek");
f.people.create(first_name: "Justice", last_name: "Vozenilek", dob: Date.new(1982, 3, 22));
f.people.create(first_name: "Mallory", last_name: "Protich", dob: Date.new(1984, 5, 18));
f.people.create(first_name: "Quincy", last_name: "Protich", dob: Date.new(2007, 6, 17));
f.people.create(first_name: "Tate", last_name: "Protich", dob: Date.new(2007, 8, 12));
