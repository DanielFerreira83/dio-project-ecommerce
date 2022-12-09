-- criação de banco de dados para o cenário de E-commerce
create database ecommerce;
use ecommerce;

-- criar tabela cliente
create table clients(
	idClient int primary key auto_increment,
    Fname varchar(10) not null,
    Minit char(3),
    Lname varchar(20),
    CPF char(11) not null,
    Address varchar(45),
    constraint unique_cpf_client unique(CPF)
);
-- criar tabela produto
-- size equivale a dimenssao do produto
create table product(
	idProduct int primary key auto_increment,
    Pname varchar(10) not null,
    Classification_kids bool default false,
    Category enum('Eletronico','Vestuario','Brinquedos', 'Alimentos','Nóveis') not null,
	Avaliation float default 0,
    Size varchar(10)
);

-- criar tabela pedido
create table orders(
	idOrder int primary key auto_increment,
    idOrderClient int,
	OrderStatus enum('Cancelado','Confirmado','Em processamento') default 'Em processamento',
    OrderDescription varchar(255),
    SendValue float default 10,
    paymentCash  bool default false,
    constraint fk_orders_client foreign key (idOrderClient) references clients(idClient)
);

-- criar tabela pagamento
create table payment(
	idclient int,
    idPayment int,
    typePayment enum('Boleto','Cartão','Dois Cartões'),
    limitAvailable float,
    primary key (idclient, idPayment)
);

-- criar tabela estoque
create table productStorage(
	idProdStorage int primary key auto_increment,
    storageLocation varchar(255),
    Quantidade float default 0
);

-- criar tabela fornecedor
create table supplier(
	idSupplier int primary key auto_increment,
	SocialName varchar(255) not null,
    CNPJ char(15) not null,
    contact char(11) not null,
    constraint unique_supplier unique (CNPJ)
);

-- criar tabela vendedor
create table seller(
	idSeller int primary key auto_increment,
	SocialName varchar(255) not null,
    AbstratctName varchar(255),
    CNPJ char(15),
    CPF char(9),
    location varchar(255),
    contact char(11) not null,
    constraint unique_cnpj_seller unique (CNPJ),
    constraint unique_cpf_seller unique (CPF)
);

-- criar tabela produto/fornecedor
create table productSeller(
	idPseller int,
    idPproduct int,
    prodQuantity int default 1,
    primary key (idPseller, idPproduct),
    constraint fk_product_seller foreign key (idPseller) references seller(idSeller),
    constraint fk_product_product foreign key (idPproduct) references product(idProduct)
);

-- criar tabela produto em estoque
create table storageLocation(
	idLproduct int,
    idLstorage int,
    locatoin varchar(255) not null,
    primary key (idLproduct, idLstorage),
    constraint fk_storage_location_product foreign key (idLproduct) references product(idProduct),
    constraint fk_storagelocation_storage foreign key (idLstorage) references productStorage(idProdStorage)
);

-- criar tabela produto/pedido
create table productOrder(
	idPOproduct int,
    idPOrder int,
    pdQuantity int default 1,
    poStatus enum('Disponível', 'Sem estoque') default 'Disponível',
    primary key (idPOproduct, idPOrder),
    constraint fk_productorder_seller foreign key (idPOproduct) references product(idProduct),
    constraint fk_productorder_product foreign key (idPOrder) references orders(idOrder)
);

create table productSupplier(
	idPsSupplier int,
    idPsProduct int,
    Quantity int default 1,
    primary key (idPsSupplier, idPsproduct),
    constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier(idSupplier),
    constraint fk_product_supplier_product foreign key (idPsProduct) references product(idProduct)
);

