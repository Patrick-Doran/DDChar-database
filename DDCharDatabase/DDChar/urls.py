from django.urls import path

from . import views

urlpatterns = [
    #index
    path('', views.index, name='index'),
    #/DDChar/character/userName
    path('spells/', views.spells, name='spells'),
]